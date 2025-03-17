/**
 * Інтерфейс Підписника визначає метод update, який викликається 
 * Видавцем при зміні його стану
 */
interface Observer {
    update(subject: Subject): void;
}

/**
 * Інтерфейс Видавця оголошує набір методів для керування підписниками
 */
interface Subject {
    // Приєднує підписника до видавця
    attach(observer: Observer): void;
    
    // Відʼєднує підписника від видавця
    detach(observer: Observer): void;
    
    // Оповіщає всіх підписників про подію
    notify(): void;
}

/**
 * Конкретний Видавець містить деякий важливий стан і оповіщає підписників,
 * коли цей стан змінюється
 */
class NewsPublisher implements Subject {
    // Список підписників. У реальному житті список підписників може зберігатися
    // в більш детальному вигляді (за типом події тощо)
    private observers: Observer[] = [];
    
    // Стан Видавця, що цікавить підписників
    private latestNews: string = "";

    /**
     * Приєднує нового підписника до списку
     */
    public attach(observer: Observer): void {
        const isExist = this.observers.includes(observer);
        if (isExist) {
            return console.log('Підписник вже приєднаний');
        }
        
        this.observers.push(observer);
        console.log('Підписник приєднаний');
    }

    /**
     * Відʼєднує підписника від списку
     */
    public detach(observer: Observer): void {
        const observerIndex = this.observers.indexOf(observer);
        
        if (observerIndex === -1) {
            return console.log('Такого підписника не існує');
        }
        
        this.observers.splice(observerIndex, 1);
        console.log('Підписник відʼєднаний');
    }

    /**
     * Оповіщає всіх підписників про зміну стану
     */
    public notify(): void {
        console.log('Оповіщення всіх підписників...');
        
        for (const observer of this.observers) {
            observer.update(this);
        }
    }

    /**
     * Зазвичай логіка Видавця є частиною бізнес-логіки програми.
     * У цьому прикладі видавець публікує нову новину, що змінює
     * його стан і запускає оповіщення
     */
    public publishNews(news: string): void {
        this.latestNews = news;
        console.log(`NewsPublisher: Опубліковано нову новину: ${news}`);
        this.notify();
    }

    /**
     * Метод, що дозволяє підписникам отримати поточний стан видавця
     */
    public getLatestNews(): string {
        return this.latestNews;
    }
}

/**
 * Конкретні Підписники реагують на оновлення, що випускає Видавець,
 * до якого вони були приєднані
 */
class EmailSubscriber implements Observer {
    private email: string;

    constructor(email: string) {
        this.email = email;
    }

    /**
     * Отримує оновлення від видавця
     */
    public update(subject: NewsPublisher): void {
        if (subject instanceof NewsPublisher) {
            console.log(`EmailSubscriber ${this.email}: Отримано нову новину: ${subject.getLatestNews()}`);
        }
    }
}

/**
 * Інший тип Конкретного Підписника, який реагує на оновлення по-своєму
 */
class MobileAppSubscriber implements Observer {
    private userId: string;

    constructor(userId: string) {
        this.userId = userId;
    }

    /**
     * Отримує оновлення від видавця і відправляє push-сповіщення
     */
    public update(subject: NewsPublisher): void {
        if (subject instanceof NewsPublisher) {
            console.log(`MobileAppSubscriber ${this.userId}: Надіслано push-сповіщення про новину: ${subject.getLatestNews()}`);
        }
    }
}

/**
 * Клієнтський код
 */
function demoObserverPattern(): void {
    // Створюємо видавця
    const publisher = new NewsPublisher();

    // Створюємо підписників
    const emailSubscriber1 = new EmailSubscriber("john@example.com");
    const emailSubscriber2 = new EmailSubscriber("jane@example.com");
    const mobileSubscriber = new MobileAppSubscriber("user_123");

    // Додаємо підписників до видавця
    publisher.attach(emailSubscriber1);
    publisher.attach(emailSubscriber2);
    publisher.attach(mobileSubscriber);

    // Публікуємо новину - всі підписники будуть оповіщені
    publisher.publishNews("Нова версія TypeScript 5.0 випущена!");

    console.log("\n");

    // Відключаємо одного підписника
    publisher.detach(emailSubscriber1);

    // Публікуємо ще одну новину - тільки активні підписники отримають оповіщення
    publisher.publishNews("Анонсовано нові функції в ECMAScript 2023");
}

// Запуск демонстрації
demoObserverPattern();

/**
 * Виведення в консоль:
 * 
 * Підписник приєднаний
 * Підписник приєднаний
 * Підписник приєднаний
 * NewsPublisher: Опубліковано нову новину: Нова версія TypeScript 5.0 випущена!
 * Оповіщення всіх підписників...
 * EmailSubscriber john@example.com: Отримано нову новину: Нова версія TypeScript 5.0 випущена!
 * EmailSubscriber jane@example.com: Отримано нову новину: Нова версія TypeScript 5.0 випущена!
 * MobileAppSubscriber user_123: Надіслано push-сповіщення про новину: Нова версія TypeScript 5.0 випущена!
 * 
 * Підписник відʼєднаний
 * NewsPublisher: Опубліковано нову новину: Анонсовано нові функції в ECMAScript 2023
 * Оповіщення всіх підписників...
 * EmailSubscriber jane@example.com: Отримано нову новину: Анонсовано нові функції в ECMAScript 2023
 * MobileAppSubscriber user_123: Надіслано push-сповіщення про новину: Анонсовано нові функції в ECMAScript 2023
 */
