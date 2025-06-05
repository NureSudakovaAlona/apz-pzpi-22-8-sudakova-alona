# FocusLearn Mobile

Мобільний клієнт програмної системи FocusLearn - Android застосунок для концентрації та навчання з IoT інтеграцією.

## Призначення проєкту

FocusLearn Mobile - це Android додаток, розроблений в рамках курсу "Архітектура програмного забезпечення". Застосунок надає функціональність для покращення концентрації через використання різних методик фокусування з автоматичним збором даних сесій через IoT пристрої.

## Функціональність

### Авторизація
- OAuth через Google та Facebook
- JWT автентифікація
- WebView інтеграція для OAuth flow

### Таймер концентрації
- Вибір методик концентрації (Pomodoro, Flow, 90/30)
- Інтерактивний круговий таймер
- Автоматичне перемикання фаз роботи та відпочинку
- IoT інтеграція для автоматичного запису даних сесій концентрації

### Управління профілем
- Перегляд та редагування особистих даних
- Зміна налаштувань мови
- Синхронізація з серверною частиною

### Статистика
- Аналітика ефективності по періодах
- Розрахунок коефіцієнта продуктивності
- Визначення найефективніших методик
- Візуалізація прогресу

### Інтернаціоналізація
- Підтримка української та англійської мов
- Динамічне перемикання мови інтерфейсу

## Технології

- Kotlin
- Jetpack Compose
- Material Design 3
- MVVM Architecture
- Dagger Hilt
- Retrofit + OkHttp
- StateFlow + Coroutines
- DataStore Preferences
- Navigation Compose

## Вимоги для запуску

- Android Studio Arctic Fox або новіше
- JDK 8+
- Android SDK 24+
- Kotlin 1.8+

## Інструкції для запуску

1. Клонуйте репозиторій:
```
git clone https://github.com/your-username/focuslearn-mobile.git
cd focuslearn-mobile
```

2. Відкрийте проєкт в Android Studio

3. Налаштуйте API URL у файлі app/build.gradle.kts:
```
buildConfigField("String", "API_BASE_URL", "\"YOUR_SERVER_URL/api/\"")
```

4. Додайте OAuth ключі у app/src/main/res/values/strings.xml:
```
<string name="default_web_client_id">YOUR_GOOGLE_CLIENT_ID</string>
<string name="facebook_app_id">YOUR_FACEBOOK_APP_ID</string>
```

5. Синхронізуйте проєкт з Gradle

6. Запустіть застосунок на пристрої або емуляторі
