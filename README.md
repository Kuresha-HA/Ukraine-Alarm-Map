# 🇺🇦 Ukraine Alarm Map для Home Assistant

**Інтерактивна карта повітряних тривог України для Home Assistant з підтримкою відстеження безпілотників та загроз у реальному часі.**

Цей додаток інтегрує офіційну веб-карту повітряних тривог України безпосередньо в Home Assistant через **Ingress**.

Карта відкривається як окрема панель у бічному меню Home Assistant та не потребує створення окремого Lovelace Dashboard або iframe.

> **Поточна версія: v1.5.0 · Stable**

## ✨ Можливості

- 🗺️ оновлена інтерактивна векторна карта України (MapLibre GL);
- 🛸 **відображення руху безпілотників («Шахед», реактивні дрони), ракет, КАБ у реальному часі**;
- 🔥 **відображення зон підвищеної небезпеки та теплових слідів загроз**;
- 🚨 відображення актуальних тривог у реальному часі;
- 📍 вибір окремих областей на карті;
- 📋 перегляд списку активних загроз (панель «Загрози»);
- 📊 перегляд інформації про область;
- 🔄 швидке оновлення даних у реальному часі через WebSocket (Centrifugo);
- 🌐 робота через Home Assistant Ingress без відкриття зовнішніх портів;
- 📱 підтримка комп'ютерів, планшетів та смартфонів;
- 🎛️ компактна панель перемикання відображення цілей, небезпеки та тем;
- 🚫 автоматичне приховування зайвих банерів, діалогів онбордингу та зовнішніх посилань.

## 📦 Встановлення

1. Відкрийте **Settings → Add-ons → Add-on Store**.
2. Додайте GitHub-репозиторій цього проєкту як додатковий репозиторій:
   `https://github.com/Kuresha-HA/Ukraine-Alarm-Map`
3. Знайдіть та встановіть **Ukraine Alarm Map Clean**.
4. Запустіть додаток.
5. Відкрийте **Тривоги України** у бічному меню Home Assistant.

Після встановлення карта доступна як окрема панель Home Assistant.

## 🧩 Як це працює

Додаток використовує Home Assistant **Ingress** та Nginx як reverse proxy для офіційної веб-карти:
- Підтримує MapLibre GL та векторні стилі OpenFreeMap.
- Перенаправляє запити до GeoJSON-контурів областей та іконок цілей через безпечний Ingress-проксі.
- Проксує WebSocket-з'єднання з Centrifugo (`wss://ws.ukrainealarm.com/connection/websocket`), зберігаючи передачу даних про тривоги й рух цілей у реальному часі.
- Зайві елементи оригінальної веб-сторінки (шапка, банери, меню онбордингу) охайно приховані, зберігаючи інтерактивність та високу швидкість роботи.

## 🌐 Офіційне джерело

Оригінальна карта:

https://map.ukrainealarm.com/

Дані та сама карта надходять з офіційного веб-сайту Ukraine Alarm. Цей проєкт є адаптацією веб-карти для використання всередині Home Assistant і не є офіційним продуктом Ukraine Alarm.

## 🔧 Технічна інформація

- **Home Assistant Add-on**
- **Home Assistant Ingress**
- **Nginx**
- **WebSocket / Centrifugo**
- **MapLibre GL / Vector Tiles**
- **Офіційна карта:** map.ukrainealarm.com
- **Поточна версія:** **1.5.0**

## 📋 Версії

| Версія | Опис |
|---|---|
| **1.5.0** | Підтримка оновленої карти MapLibre, руху безпілотників («Шахед», ракети, КАБ), теплових слідів загроз, автопропуску онбордингу та маршрутизації Ingress для векторних ресурсів |
| **1.4.12** | Стабільна попередня версія |
| 1.4.x | Розвиток та оптимізація інтеграції карти з Home Assistant |

---

# 🇬🇧 English

**Interactive Ukraine air-raid map for Home Assistant with live drone and threat tracking.**

This add-on integrates the official Ukraine Alarm web map into Home Assistant using **Ingress**.

### Features

- Updated interactive vector map of Ukraine (MapLibre GL)
- **Live drone («Shahed», jet drones), missile, and guided bomb movement tracking**
- **High danger zones and threat trail visualization**
- Real-time threat & alarm updates
- Region selection and detailed information
- Interactive **Threats** panel
- WebSocket updates through Home Assistant Ingress
- Auto-acceptance of onboarding modal
- No separate public port is required
- Works on desktop, tablet, and mobile devices

**Current version: v1.5.0 · Stable**

## Installation

1. Open **Settings → Add-ons → Add-on Store**.
2. Add this GitHub repository as an additional repository:
   `https://github.com/Kuresha-HA/Ukraine-Alarm-Map`
3. Install **Ukraine Alarm Map Clean**.
4. Start the add-on.
5. Open **Ukraine Alarm Map / Тривоги України** from the Home Assistant sidebar.

## Source

Official map: https://map.ukrainealarm.com/

This project adapts the official web map for use inside Home Assistant and is not an official Ukraine Alarm product.

## License / Disclaimer

The project acts as an integration/proxy layer for the publicly available official web map. The original map, data and related services remain the property of their respective owners.
