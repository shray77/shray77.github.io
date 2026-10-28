# shray77.github.io

Личный сайт-визитка: **[shray77.github.io](https://shray77.github.io/)**

Ветеринарная медицина × код. Витрина всей открытой экосистемы — **20 проектов**,
из них 15 живых демо на GitHub Pages:

| Раздел | Проекты |
|---|---|
| Мониторинг и прогнозы | [ВЕТМЕТЕО](https://github.com/shray77/vet-meteo) · [ВетКарта](https://github.com/shray77/vet-heatmap) · [ВетХаб](https://github.com/shray77/vet-hub) · [VetFlu](https://github.com/shray77/vetflu-site) · [VetFlu Forecast](https://github.com/shray77/vetflu-forecast) · [VetRecall](https://github.com/shray77/vetrecall-site) · [BioThreat Watch](https://github.com/shray77/biothreat-site) |
| Данные и ИИ | [VetDigest](https://github.com/shray77/vetdigest-site) · [VetDigest LLM](https://github.com/shray77/vet-digest-llm) · [RSS-конвейер](https://github.com/shray77/rss-core-site) · [VetInSilico Hub](https://github.com/shray77/vet-insilico) |
| Инструменты врача | [VetTools](https://github.com/shray77/vettools) · [ФЭКРТ](https://github.com/shray77/vetfecrt-site) ([демо](https://shray77.github.io/vetfecrt-site/)) · [VetVoice](https://github.com/shray77/vetvoice) · [ВетЭко](https://github.com/shray77/vetvoice-rag) · [VetLearn AI](https://github.com/shray77/vetlearn-web) ([демо](https://shray77.github.io/vetlearn-web/)) |
| Платформа | [VetOS](https://github.com/shray77/vetos) · [VetAPI](https://github.com/shray77/vet-api) |
| Пилоты и пробы (отдельная вкладка) | [Вет-Пилоты](https://github.com/shray77/vet-pilots) · [ВетПетри](https://github.com/shray77/vetpetri) |

На визитке: скриншоты живых веб-морд (ассеты `assets/shots/*.jpg`, 960px),
фильтр проектов по разделам, отдельная вкладка «Пилоты и пробы»,
индикаторы свежести данных (fetch JSON с витрин), схема конвейера экосистемы.

## Технически

- Одна HTML-страница (`index.html`) + копия ядра `vet-ds.css` (v2.4.1) — без сборки.
- Дизайн: **vet-ds v2.4.1 «Научная периодика»** — светлая бумага по умолчанию +
  тёмная тема тумблером (localStorage `vetds-theme`), Instrument Serif × Inter ×
  IBM Plex Mono (Google Fonts, офлайн-деградация на системные), иконки Lucide
  inline-SVG, без эмодзи в UI. Карточки каталога красятся токенами категории.
- Скриншоты витрин: agent-browser 1280×800 → Pillow → JPEG 960×600 в
  `assets/shots/`; og-карточка `assets/og.jpg` 1200×630 — HTML-рендер того же
  конвейера. Перегенерация — после крупных редизайнов витрин.
- Хостинг: GitHub Pages, ветка `main`, корень репозитория (`.nojekyll`).
- SEO: sitemap.xml, robots.txt, JSON-LD (Person + ItemList из 20 позиций).

## Правки

Отредактируй `index.html` и запуши в `main` — Pages пересоберёт сам.
Свежесть скриншотов: перегенерация `assets/shots/` после крупных редизайнов витрин.

MIT © shray77
