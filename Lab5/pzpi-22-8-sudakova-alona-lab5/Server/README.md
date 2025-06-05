# FocusLearn Server

Серверна частина системи управління концентрацією та продуктивністю у навчальному процесі.

## Опис системи

FocusLearn - це платформа для підвищення продуктивності навчання через:
- **Методики концентрації** (Pomodoro та інші техніки)
- **IoT інтеграцію** для автоматичного відстеження сесій
- **Завдання від репетиторів** з можливістю оцінювання
- **Аналітику продуктивності** з персоналізованими рекомендаціями
- **Навчальні матеріали** та їх організацію

## 🛠 Технології

- **Backend**: ASP.NET Core 7.0
- **База даних**: SQL Server
- **ORM**: Entity Framework Core
- **Аутентифікація**: JWT + OAuth2 (Google, Facebook)
- **IoT комунікація**: MQTT
- **Локалізація**: Українська/Англійська
- **API документація**: Swagger/OpenAPI

## Передумови

- [.NET 7.0 SDK](https://dotnet.microsoft.com/download/dotnet/7.0)
- [SQL Server](https://www.microsoft.com/sql-server) (LocalDB підійде для розробки)
- [Visual Studio 2022](https://visualstudio.microsoft.com/) або [VS Code](https://code.visualstudio.com/)
- Git

## Розгортання

### 1. Клонування репозиторію
```
git clone [<repository-url>](https://github.com/avokadus725/FocusLearn.git)
cd focuslearn-server
```

### 2. Налаштування бази даних
```
# Встановлення EF Tools (якщо не встановлено)
dotnet tool install --global dotnet-ef

# Оновлення бази даних
dotnet ef database update
```

### 3. Конфігурація

Створіть файл `appsettings.Development.json`:
```
{
  "ConnectionStrings": {
    "DefaultConnection": "Server=(localdb)\\mssqllocaldb;Database=FocusLearnDB;Trusted_Connection=true;TrustServerCertificate=true;"
  },
  "Jwt": {
    "SecretKey": "your-super-secret-key-minimum-32-characters",
    "Issuer": "FocusLearnAPI",
    "Audience": "FocusLearnClient"
  },
  "Authentication": {
    "Google": {
      "ClientId": "your-google-client-id",
      "ClientSecret": "your-google-client-secret"
    },
    "Facebook": {
      "AppId": "your-facebook-app-id",
      "AppSecret": "your-facebook-app-secret"
    }
  },
  "ClientUrl": "http://localhost:3000"
}
```

### 4. Запуск серверу
```
dotnet restore
dotnet run
```

Сервер буде доступний за адресою: `https://localhost:7000`

API документація: `https://localhost:7000/swagger`

## 🔧 Основні функції API

### Аутентифікація
- `GET /api/auth/login-google` - Вхід через Google
- `GET /api/auth/login-facebook` - Вхід через Facebook

### Користувачі
- `GET /api/users/my-profile` - Профіль поточного користувача
- `PUT /api/users/my-profile` - Оновлення профілю

### Методики концентрації
- `GET /api/concentrationmethods` - Список методик
- `POST /api/concentrationmethods` - Створення методики (Admin)

### Таймер сесій
- `POST /api/timer/start` - Запуск сесії концентрації
- `GET /api/timer/status` - Статус поточної сесії
- `POST /api/timer/pause` - Пауза/відновлення
- `POST /api/timer/stop` - Завершення сесії

### Завдання
- `GET /api/assignments/all` - Доступні завдання
- `GET /api/assignments/my-assignments` - Мої завдання
- `POST /api/assignments/{id}/take` - Взяти завдання (Student)
- `POST /api/assignments/{id}/submit` - Здати завдання (Student)
- `POST /api/assignments/{id}/grade` - Оцінити завдання (Tutor)

### Аналітика
- `GET /api/businesslogic/user-statistics` - Статистика користувача
- `GET /api/businesslogic/most-effective-method` - Найефективніша методика
- `GET /api/businesslogic/productivity-coefficient` - Коефіцієнт продуктивності

## 👥 Ролі користувачів

- **Student** - основна роль, доступ до всіх навчальних функцій
- **Tutor** - може створювати завдання та навчальні матеріали
- **Admin** - повний доступ до системи та адміністративних функцій

## 🌐 IoT інтеграція

Система підтримує MQTT протокол для інтеграції з IoT пристроями:
- **Топік відправки**: `focuslearn/concentration`
- **Топік отримання**: `focuslearn/sessions`
- **Брокер**: `34.243.217.54:1883`

## 📁 Структура серверної частини

```
├── Controllers/          # API контролери
├── Models/
│   ├── Domain/          # Entity моделі
│   └── DTO/             # Data Transfer Objects
├── Repositories/
│   ├── Abstract/        # Інтерфейси сервісів
│   └── Implementation/  # Реалізація сервісів
├── Resources/           # Файли локалізації
├── Middleware/          # Користувацькі middleware
└── Filters/             # Фільтри для запитів
```

## 🔒 Безпека

- JWT токени для авторизації
- OAuth2 інтеграція з Google/Facebook
- Фільтр статусу користувача
- CORS політика для клієнтських додатків

## ⚠️ Важливі примітки

- База даних містить тестові дані
- MQTT брокер може бути недоступний
Якщо виникають проблеми з розгортанням:
1. Перевірте правильність connection string
2. Переконайтеся, що SQL Server запущений
3. Виконайте `dotnet ef database update`
4. Перевірте порти (7000/7001) на доступність
