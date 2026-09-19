# 🇺🇦 Ukraine Alarm Map для Home Assistant

**Інтерактивна карта повітряних тривог України для Home Assistant.**

Цей додаток інтегрує офіційну веб-карту повітряних тривог України безпосередньо в Home Assistant через **Ingress**.

Карта відкривається як окрема панель у бічному меню Home Assistant та не потребує створення окремого Lovelace Dashboard або iframe.

> **Поточна версія: v1.4.12 · Stable**

## ✨ Можливості

- 🗺️ інтерактивна карта повітряних тривог України;
- 🚨 відображення актуальних загроз у реальному часі;
- 📍 вибір окремих областей на карті;
- 📋 перегляд списку активних загроз;
- 📊 перегляд інформації про область;
- 🔄 оновлення даних у реальному часі через WebSocket;
- 🌐 робота через Home Assistant Ingress;
- 📱 підтримка комп'ютерів, планшетів та смартфонів;
- 🔐 не потребує окремого відкритого порту в інтернет.

## 📦 Встановлення

1. Відкрийте **Settings → Add-ons → Add-on Store**.
2. Додайте GitHub-репозиторій цього проєкту як додатковий репозиторій.
3. Встановіть **Ukraine Alarm Map**.
4. Запустіть додаток.
5. Відкрийте **Тривоги України** у бічному меню Home Assistant.

Після встановлення карта доступна як окрема панель Home Assistant.

## 🧩 Як це працює

Додаток використовує Home Assistant **Ingress** та Nginx як proxy для офіційної веб-карти. WebSocket-з'єднання також проходить через Ingress, завдяки чому актуальні дані про тривоги продовжують оновлюватися в реальному часі.

Зайві елементи оригінальної веб-сторінки приховані, але основна інтерактивність карти, легенда, вибір областей, інформаційні вікна та панель **«Загрози»** зберігаються.

## 🌐 Офіційне джерело

Оригінальна карта:

https://map.ukrainealarm.com/

Дані та сама карта надходять з офіційного веб-сайту Ukraine Alarm.

Цей проєкт є адаптацією веб-карти для використання всередині Home Assistant і не є офіційним продуктом Ukraine Alarm.

## 🔧 Технічна інформація

- **Home Assistant Add-on**
- **Home Assistant Ingress**
- **Nginx**
- **WebSocket / Centrifugo**
- **Офіційна карта:** map.ukrainealarm.com
- **Поточна версія:** **1.4.12**

## 📋 Версії

| Версія | Опис |
|---|---|
| **1.4.12** | Поточна стабільна версія |
| 1.4.x | Розвиток та оптимізація інтеграції карти з Home Assistant |

---

# 🇬🇧 English

**Interactive Ukraine air-raid map for Home Assistant.**

This add-on integrates the official Ukraine Alarm web map into Home Assistant using **Ingress**.

### Features

- Interactive Ukraine air-raid map
- Real-time threat updates
- Region selection and information
- Interactive **Threats** panel
- WebSocket updates through Home Assistant Ingress
- No separate public port is required
- Works on desktop, tablet and mobile devices

**Current version: v1.4.12 · Stable**

## Installation

1. Open **Settings → Add-ons → Add-on Store**.
2. Add this GitHub repository as an additional repository.
3. Install **Ukraine Alarm Map**.
4. Start the add-on.
5. Open **Ukraine Alarm Map / Тривоги України** from the Home Assistant sidebar.

## Source

Official map: https://map.ukrainealarm.com/

This project adapts the official web map for use inside Home Assistant and is not an official Ukraine Alarm product.

## License / Disclaimer

The project acts as an integration/proxy layer for the publicly available official web map. The original map, data and related services remain the property of their respective owners.
