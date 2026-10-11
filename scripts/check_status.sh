#!/usr/bin/env bash
# =====================================================================
# VetInSilico — проверка живости всех витрин/эндпоинтов экосистемы.
# Запускается почасовым воркфлоу .github/workflows/status.yml
# Результат: status.json в корне. Файл перезаписывается ТОЛЬКО при
# изменении состояния (state_hash) — история коммитов остаётся чистой.
# =====================================================================
set -u
cd "$(dirname "$0")/.."
OUT="status.json"

TMP=$(mktemp -d)
trap 'rm -rf "$TMP"' EXIT
BODY="$TMP/body"
TSV="$TMP/checks.tsv"
: > "$TSV"

# Формат: id|группа|url|ожидаемый код|фраза (пусто = проверять только код)
CHECKS=$(cat <<'EOF'
hub|Витрины|https://shray77.github.io/|200|VetInSilico
vetflu|Витрины|https://shray77.github.io/vetflu-site/|200|VetFlu
vet-heatmap|Витрины|https://shray77.github.io/vet-heatmap/|200|
vet-meteo|Витрины|https://shray77.github.io/vet-meteo/|200|
rss-core-site|Витрины|https://shray77.github.io/rss-core-site/|200|
vetdigest-site|Витрины|https://shray77.github.io/vetdigest-site/|200|
vet-insilico|Витрины|https://shray77.github.io/vet-insilico/|200|
vettools|Витрины|https://shray77.github.io/vettools/|200|
biothreat-site|Витрины|https://shray77.github.io/biothreat-site/|200|
vetrecall-site|Витрины|https://shray77.github.io/vetrecall-site/|200|
vetflu-feed|Эндпоинты|https://shray77.github.io/vetflu-site/feed.xml|200|<rss version
vetflu-model|Эндпоинты|https://shray77.github.io/vetflu-site/data/model.json|200|"nodes"
vetflu-og|Эндпоинты|https://shray77.github.io/vetflu-site/og-image.png|200|
terms-biothreat|Terms|https://shray77.github.io/biothreat-site/terms.html|200|
terms-rss-core|Terms|https://shray77.github.io/rss-core-site/terms.html|200|
terms-heatmap|Terms|https://shray77.github.io/vet-heatmap/terms.html|200|
terms-insilico|Terms|https://shray77.github.io/vet-insilico/terms/|200|
terms-meteo|Terms|https://shray77.github.io/vet-meteo/terms.html|200|
terms-vetdigest|Terms|https://shray77.github.io/vetdigest-site/terms.html|200|
terms-vetrecall|Terms|https://shray77.github.io/vetrecall-site/terms.html|200|
terms-vetflu|Terms|https://shray77.github.io/vetflu-site/terms.html|200|
w-rss-core|Воркеры|https://rss-core.shray77.workers.dev/|200|
w-vetdigest|Воркеры|https://vetdigest.shray77.workers.dev/|200|
w-biothreat|Воркеры|https://biothreat.shray77.workers.dev/|200|
w-vetrecall|Воркеры|https://vetrecall.shray77.workers.dev/|200|
w-vet-api|Воркеры|https://vet-api.shray77.workers.dev/|200|"service"
EOF
)

while IFS='|' read -r id grp url code phrase; do
  [ -z "$id" ] && continue
  meta=$(curl -sL -m 20 -o "$BODY" -w "%{http_code} %{time_total}" "$url" 2>/dev/null || echo "000 0")
  got=$(echo "$meta" | cut -d' ' -f1)
  ms=$(echo "$meta" | cut -d' ' -f2)
  ok=1; exp="$got/$code"
  [ "$got" != "$code" ] && ok=0
  if [ -n "$phrase" ] && [ "$ok" = "1" ]; then
    exp="$exp+фраза"
    grep -aqF -- "$phrase" "$BODY" 2>/dev/null || { ok=0; exp="$exp НЕНАЙДЕНА"; }
  fi
  printf '%s\t%s\t%s\t%s\t%s\t%s\t%s\n' "$id" "$grp" "$url" "$got" "$ok" "$ms" "$exp" >> "$TSV"
  [ "$ok" = "1" ] && mark="✅" || mark="❌"
  echo "$mark $id -> HTTP $got ($exp)"
done <<< "$CHECKS"

# Сборка status.json (python3 — на ubuntu-latest есть, локально тоже)
python3 - "$TSV" "$OUT" <<'PYEOF'
import json, hashlib, sys, datetime, os

tsv, out_path = sys.argv[1], sys.argv[2]
now = datetime.datetime.now(datetime.timezone.utc).strftime("%Y-%m-%dT%H:%M:%SZ")

checks = []
for line in open(tsv, encoding="utf-8"):
    p = line.rstrip("\n").split("\t")
    if len(p) < 7: continue
    checks.append({"id": p[0], "group": p[1], "url": p[2], "code": int(p[3]),
                   "ok": p[4] == "1", "ms": round(float(p[5]) * 1000), "expected": p[6]})

state_hash = hashlib.sha256(
    "\n".join(sorted(f"{c['id']}:{c['ok']}:{c['code']}" for c in checks)).encode()
).hexdigest()[:12]

# Если состояние не изменилось — файл не трогаем (воркфлоу не коммитит)
if os.path.exists(out_path):
    try:
        prev = json.load(open(out_path, encoding="utf-8"))
        if prev.get("state_hash") == state_hash:
            print(f"state unchanged ({state_hash}) — status.json не тронут")
            sys.exit(0)
        last_change = prev.get("checked_at", now)
    except Exception:
        last_change = now
else:
    last_change = now

failed = [c for c in checks if not c["ok"]]
overall = "ok" if not failed else ("down" if len(failed) == len(checks) else "degraded")

out = {
    "service": "vetinsilico-status",
    "note": "status.json обновляется ТОЛЬКО при изменении состояния; живость монитора — бейдж воркфлоу status-check",
    "generated_for_run": now,
    "checked_at": now,
    "last_change_at": last_change,
    "state_hash": state_hash,
    "overall": overall,
    "checks_total": len(checks),
    "checks_failed": len(failed),
    "failed_ids": [c["id"] for c in failed],
    "checks": checks,
}
with open(out_path, "w", encoding="utf-8") as f:
    json.dump(out, f, ensure_ascii=False, indent=1)
    f.write("\n")
print(f"state {state_hash}: {overall}, {len(failed)}/{len(checks)} провалено — status.json перезаписан")
PYEOF
