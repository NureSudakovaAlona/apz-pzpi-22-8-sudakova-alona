import random

class AdaptiveLearningSystem:
    def __init__(self):
        self.user_level = 1  # Початковий рівень користувача
        self.mastery_threshold = 0.8  # Поріг майстерності для переходу на наступний рівень

    def assess_knowledge(self, correct_answers, total_questions):
        """
        Оцінює рівень знань користувача на основі кількості правильних відповідей.
        """
        accuracy = correct_answers / total_questions
        if accuracy >= self.mastery_threshold:
            self.user_level += 1  # Підвищення рівня при досягненні порогу майстерності
        elif accuracy < 0.5:
            self.user_level = max(1, self.user_level - 1)  # Зниження рівня при низькій успішності

    def select_next_exercise(self):
        """
        Вибирає наступне завдання відповідно до поточного рівня користувача.
        """
        exercises = {
            1: ['Завдання 1.1', 'Завдання 1.2', 'Завдання 1.3'],
            2: ['Завдання 2.1', 'Завдання 2.2', 'Завдання 2.3'],
            3: ['Завдання 3.1', 'Завдання 3.2', 'Завдання 3.3'],
            # Додаткові рівні та завдання можуть бути додані тут
        }
        return random.choice(exercises.get(self.user_level, ['Завдання за замовчуванням']))

    def adapt_difficulty(self, response_time):
        """
        Адаптує складність завдань на основі часу відповіді користувача.
        """
        if response_time < 5:  # Швидка відповідь
            self.user_level += 1
        elif response_time > 15:  # Повільна відповідь
            self.user_level = max(1, self.user_level - 1)

# Приклад використання
learning_system = AdaptiveLearningSystem()

# Симуляція відповідей користувача
learning_system.assess_knowledge(correct_answers=8, total_questions=10)
next_exercise = learning_system.select_next_exercise()
print(f"Наступне завдання: {next_exercise}")

# Симуляція часу відповіді
learning_system.adapt_difficulty(response_time=12)
print(f"Поточний рівень користувача: {learning_system.user_level}")
