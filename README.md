# shray77.github.io

Личный сайт-визитка: **[shray77.github.io](https://shray77.github.io/)**

Ветеринарная медицина × код. Витрина всей открытой экосистемы — **18 проектов**,
из них 12 живых демо на GitHub Pages:

| Раздел | Проекты |
|---|---|
| Мониторинг и прогнозы | [ВЕТМЕТЕО](https://github.com/shray77/vet-meteo) · [ВетКарта](https://github.com/shray77/vet-heatmap) · [ВетХаб](https://github.com/shray77/vet-hub) · [VetFlu](https://github.com/shray77/vetflu-site) · [VetFlu Forecast](https://github.com/shray77/vetflu-forecast) · [VetRecall](https://github.com/shray77/vetrecall-site) · [BioThreat Watch](https://github.com/shray77/biothreat-site) |
| Данные и ИИ | [VetDigest](https://github.com/shray77/vetdigest-site) · [VetDigest LLM](https://github.com/shray77/vet-digest-llm) · [RSS-конвейер](https://github.com/shray77/rss-core-site) |
| Инструменты врача | [VetTools](https://github.com/shray77/vettools) · [VetVoice](https://github.com/shray77/vetvoice) · [ВетЭко](https://github.com/shray77/vetvoice-rag) |
| Платформа | [VetOS](https://github.com/shray77/vetos) · [VetAPI](https://github.com/shray77/vet-api) |
| Пилоты и пробы (отдельная вкладка) | [Вет-Пилоты](https://github.com/shray77/vet-pilots) · [VetInSilico Hub](https://github.com/shray77/vet-insilico) · [VetLearn AI](https://gitlab.com/shray77/vetlearn-web) ([демо](https://shray77.github.io/vetlearn-web/)) |

На визитке: скриншоты живых веб-морд (ассеты `assets/shots/*.jpg`, 960px),
фильтр проектов по разделам, отдельная вкладка «Пилоты и пробы»,
индикаторы свежести данных (fetch JSON с витрин), схема конвейера экосистемы.

## Технически

- Одна HTML-страница (`index.html`), ноль зависимостей и сборки —
  инлайн-CSS, системные шрифты, favicon как inline-SVG.
- Скриншоты: Playwright (1440×900) → sharp → JPEG 960w в `assets/shots/`;
  og-коллаж `assets/og.jpg` 1200×630 собирается тем же скриптом.
- Хостинг: GitHub Pages, ветка `main`, корень репозитория (`.nojekyll`).
- Дизайн: тёмная тема, акцент — бирюза; адаптив от 360px; без внешних CDN —
  открывается из РФ.

## Правки

Отредактируй `index.html` и запуши в `main` — Pages пересоберёт сам.
Свежесть скриншотов: перегенерация `assets/shots/` после крупных редизайнов витрин.

MIT © shray77
