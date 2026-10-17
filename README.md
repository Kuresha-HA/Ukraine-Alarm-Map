# 🇺🇦 Ukraine Alarm Map для Home Assistant

**Інтерактивна карта повітряних тривог України для Home Assistant з підтримкою відстеження безпілотників та загроз у реальному часі, а також прямої трансляції на телевізори (Android TV / PiPup).**

[![Home Assistant Add-on](https://img.shields.io/badge/Home%20Assistant-Add--on-blue.svg)](https://www.home-assistant.io/)
[![Version](https://img.shields.io/badge/version-1.5.1-brightgreen.svg)](https://github.com/Kuresha-HA/Ukraine-Alarm-Map)
[![License](https://img.shields.io/badge/license-MIT-green.svg)](LICENSE)

Цей додаток інтегрує офіційну веб-карту повітряних тривог України [map.ukrainealarm.com](https://map.ukrainealarm.com/) безпосередньо в Home Assistant:
1. **Через Ingress:** карта відкривається як окрема чиста панель у бічному меню Home Assistant без зайвих банерів та онбордингу.
2. **Через локальний порт 8765:** прямий доступ для трансляції на телевізори (PiPup / Android TV), планшети настінного монтажу та Smart TV без потреби входу в обліковий запис Home Assistant!

> **Поточна версія: v1.5.1 (1.51) · Stable**

---

## ✨ Можливості

- 🗺️ **Оновлена інтерактивна векторна карта** на базі MapLibre GL.
- 🛸 **Відстеження руху цілей у реальному часі:**
  - Ударні БПЛА («Шахед», реактивні дрони);
  - Крилаті та балістичні ракети;
  - Керовані авіаційні бомби (КАБ);
  - Розвідувальні дрони.
- 🔥 **Теплові сліди та зони небезпеки:** візуалізація траєкторій та напрямків руху загроз.
- 🚨 **Актуальні тривоги:** забарвлення областей та районів із зазначенням тривалості тривоги.
- 📺 **Пряма трансляція на ТБ (PiPup / Android TV):** вивід спливаючого вікна з живою картою на екран телевізора при тривозі без вікна авторизації Home Assistant.
- 🔄 **Миттєве оновлення:** підтримка WebSocket (Centrifugo) для передачі змін без затримок.
- 🚫 **Чистий інтерфейс (Clean View):** видалені рекламні банери, вікна онбордингу, шапка та зовнішні посилання. Карта займає 100% площі екрана.
- 🛡️ **Безпека:** прямий доступ на порт 8765 за замовчуванням дозволено лише з локальних підмереж (`192.168.0.0/16`, `10.0.0.0/8`, `172.16.0.0/12`).

---

## 📦 Встановлення

1. У Home Assistant відкрийте **Налаштування (Settings) → Додатки (Add-ons) → Магазин додатків (Add-on Store)**.
2. У правому верхньому кутку натисніть три крапки `⋮` → **Репозиторії (Repositories)**.
3. Додайте адресу:
   ```text
   https://github.com/Kuresha-HA/Ukraine-Alarm-Map
   ```
4. Знайдіть у списку та встановіть **Ukraine Alarm Map Clean**.
5. Запустіть додаток (за потреби увімкніть «Запуск під час завантаження» та «Показувати на бічній панелі»).
6. Відкрийте пункт **Тривоги України** на лівій панелі Home Assistant!

---

## 📺 Трансляція карти на телевізор через PiPup (Android TV)

Завдяки доданому в версії 1.5.1 порту **8765** будь-хто може налаштувати автоматичний вивід живого віджета карти на свій телевізор (через додаток [PiPup](https://github.com/rogro82/PiPup) на Android TV). Телевізор завантажує карту напряму з локального сервера Home Assistant без запиту логіна чи пароля.

### Приклад готового скрипта Home Assistant:

Перейдіть у **Налаштування → Автоматизації та сцени → Скрипти** та створіть новий скрипт (або додайте в `scripts.yaml`):

```yaml
alias: Карта тривог на ТБ
description: "Вивід вікна з картою тривог та траєкторіями дронів на телевізор через PiPup"
sequence:
  - action: pipup.send
    target:
      entity_id: notify.pipup_bedroom_tv_2  # Замініть на ваш entity_id телевізора
    data:
      title: "🚨 Карта повітряних тривог"
      web_uri: http://192.168.1.5:8765/     # Замініть 192.168.1.5 на IP вашого Home Assistant
      media_width: 960
      web_height: 540
      position: '0'                         # 0 = Top Right, 1 = Top Left, 2 = Bottom Right, 3 = Bottom Left, 4 = Center
      duration: 20                          # Тривалість показу в секундах
mode: single
icon: mdi:television-ambient-light
```

### Приклад автоматизації (поява тривоги):
```yaml
alias: "Тривога: показати карту на телевізорі"
trigger:
  - trigger: state
    entity_id: binary_sensor.m_kiiv_air    # Ваш сенсор тривоги
    to: "on"
action:
  - action: script.karta_triwog_na_tb
```

---

## 🧩 Як це працює

Додаток базується на контейнері Nginx Alpine, який працює у двох режимах одночасно:
1. **Home Assistant Ingress:** проксує карту в адмін-панель Home Assistant, автоматично підміняючи шляхи до скриптів і стилів через заголовок `X-Ingress-Path`.
2. **Прямий Web-сервер (порт 8765):** віддає оптимізовану карту для пристроїв вашої домашньої мережі (ТБ, розумні дисплеї, браузери).
3. **WebSocket Proxy:** тунелює з'єднання до `wss://ws.ukrainealarm.com/connection/websocket`, завдяки чому точки дронів та радарні тривоги оновлюються без затримок.
4. **Clean View Injection:** інжектує спеціальні стилі та скрипти, які:
   - автоматично підтверджують онбординг у `localStorage`;
   - ховають зайві панелі та елементи управління;
   - забезпечують коректний рендеринг WebGL/MapLibre у контейнері будь-якого розміру.

---

## 🔧 Технічні параметри

| Параметр | Значення |
|---|---|
| **Тип** | Home Assistant Add-on |
| **Архітектури** | amd64, aarch64 (Raspberry Pi 3/4/5, Intel NUC, x86_64, Odroid, тощо) |
| **Порт Ingress** | Виділяється динамічно Home Assistant |
| **Локальний порт** | `8765/tcp` (налаштовується в конфігурації додатка) |
| **Джерело даних** | [map.ukrainealarm.com](https://map.ukrainealarm.com/) |
| **Версія** | **1.5.1** |

---

## 📋 Історія версій

| Версія | Зміни |
|---|---|
| **1.5.1** | 🚀 **Прямий порт 8765 для трансляції на ТБ / PiPup**: додано можливість відривати карту без авторизації Home Assistant для телевізорів, настінних планшетів та смарт-моніторів у домашній мережі. Оновлено правила безпеки підмереж. |
| **1.5.0** | 🛰️ Повна адаптація до нового рушія карти MapLibre GL: рух ударних дронів та ракет, теплові сліди цілей, автоматичний обхід онбордингу, повне проксування векторних даних через Ingress. |
| **1.4.12** | Стабільна попередня версія класичної карти. |

---

# 🇬🇧 English

**Interactive Ukraine air-raid map for Home Assistant with live drone & threat tracking and direct TV streaming (Android TV / PiPup).**

### Features
- Updated interactive vector map powered by MapLibre GL.
- **Live tracking of aerial threats:** "Shahed" strike drones, jet drones, missiles, and guided aerial bombs (KAB).
- **Threat trajectory & danger zones:** live heading lines and heat tracks.
- **Direct TV Streaming (Port 8765):** display live alarm overlays on Android TV via PiPup without requiring Home Assistant credentials.
- Real-time updates over WebSocket (Centrifugo).
- Clean interface: no ads, no banners, no onboarding popups.
- Protected direct access restricted to private local networks (RFC 1918).

### Installation
1. Go to **Settings → Add-ons → Add-on Store** in Home Assistant.
2. Click `⋮` in the top right → **Repositories** → Add `https://github.com/Kuresha-HA/Ukraine-Alarm-Map`.
3. Install **Ukraine Alarm Map Clean** and start it.
4. Access it via the sidebar or directly stream via `http://<HOME_ASSISTANT_IP>:8765/`.

### TV Streaming via PiPup (Example)
```yaml
sequence:
  - action: pipup.send
    target:
      entity_id: notify.pipup_bedroom_tv_2
    data:
      title: "🚨 Ukraine Air Alarm Map"
      web_uri: http://192.168.1.5:8765/
      media_width: 960
      web_height: 540
      position: '0'
      duration: 20
```

---

## ⚖️ Застереження / Disclaimer

Цей проєкт є неофіційною адаптацією веб-карти для використання всередині системи автоматизації Home Assistant. Усі права на оригінальну карту, сервери передачі даних та торговельні марки належать їх законним власникам ([map.ukrainealarm.com](https://map.ukrainealarm.com/)).
