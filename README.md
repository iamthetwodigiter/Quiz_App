# Quiz App

A Flutter-based interactive quiz application with gamification features, utilizing Riverpod for state management and Hive for local data persistence. This project was built as part of an internship assignment and showcases advanced UI/UX principles and modular code design.

---

## Table of Contents

- [Features](#features)
- [Technology Stack](#technology-stack)
- [Project Architecture](#project-architecture)
- [Setup and Installation](#setup-and-installation)
- [Code Walkthrough](#code-walkthrough)
  - [Key Widgets and Components](#key-widgets-and-components)
  - [State Management](#state-management)
  - [Persistent Data Handling](#persistent-data-handling)
- [Gamification Features](#gamification-features)
- [Working Demo](#working-demo)
- [Contributors](#contributors)

---

## Features

1. **Interactive Questions**:
   - Multiple-choice questions.
   - Real-time feedback with hints and solutions.

2. **Gamification**:
   - Users earn coins for correct answers.
   - Coins can be used to unlock hints or detailed solutions.

3. **Progress Tracking**:
   - Persistent storage of user progress (marks, attempted questions, etc.).
   - Summaries and analytics for completed quizzes.

4. **Offline Support**:
   - Local data persistence using Hive.

5. **Dynamic Navigation**:
   - Seamless navigation between questions.
   - Previous/Next buttons and summary screen.

---

## Technology Stack

- **Flutter**: Cross-platform framework for building the application.
- **Riverpod**: State management solution for reactive and scalable UI updates.
- **Hive**: Lightweight and high-performance local database.
- **Dart**: Programming language for Flutter development.

---

## Project Architecture

This project follows a feature-first architecture to ensure scalability and maintainability.

### Folder Structure:
```
lib/
|-- models/           # Data models (e.g., `quiz_model.dart`, `user_data_state.dart`)
|-- providers/        # Riverpod providers (e.g., `quiz_provider.dart`, `user_data_provider.dart`)
|-- screens/          # Screen widgets (e.g., `question_page.dart`)
|-- services/         # API and utility services (e.g., `api_services.dart`)
|-- utils/            # Common utilities (e.g., `gradient_decorations.dart`, `rich_text.dart`)
|-- widgets/          # Reusable widgets (e.g., `question_card.dart`)
```

---

## Setup and Installation

### Prerequisites
1. Install Flutter SDK: [Flutter Setup Guide](https://flutter.dev/docs/get-started/install).
2. Install Hive and Riverpod dependencies:
   ```sh
   flutter pub add flutter_riverpod hive_flutter dio
   ```

### Steps
1. Clone the repository:
   ```sh
   git clone https://github.com/iamthetwodigiter/Quiz_App.git
   cd Quiz_App
   ```
2. Run the application:
   ```sh
   flutter run
   ```

---

## Code Walkthrough

### Key Widgets and Components

#### **QuestionPage**
- Handles the display and navigation of quiz questions.
- Features real-time answer validation and summary dialogs.
- Utilizes `QuestionCard` for rendering individual questions.

#### **QuestionCard**
- A reusable widget for rendering a single question and its options.
- Highlights selected and correct answers.

#### **Dialogs**
- Custom dialogs for showing hints, solutions, and quiz summaries.
- Implements gamified coin deduction mechanics.

### State Management

State is managed via Riverpod providers:
- `quizProvider`: Caches quiz data using `AsyncValue` for error handling and loading states.
- `userDataProvider`: Tracks user progress, including marks, attempts, and coins.

### Persistent Data Handling

Using Hive for local storage:
- `UserDataNotifier`: Saves and retrieves user-specific data (marks, coins, progress).
- `saveQuestionProgress`: Stores details of attempted questions persistently.

#### Example:
```dart
void saveQuestionProgress({
  required String testId,
  required int questionId,
  required String selectedOption,
  required bool isCorrect,
}) {
  Map<dynamic, dynamic> testDetails = _quizBox.get(testId, defaultValue: {});
  testDetails[questionId.toString()] = {
    'selectedOption': selectedOption,
    'isCorrect': isCorrect,
  };
  _quizBox.put(testId, testDetails);
}
```

---

## Gamification Features

1. **Coins**:
   - Earn 2 coins for every correct answer.
   - Deduct 5 coins to view a hint or solution.

2. **Score Calculation**:
   - Correct answers add to the user’s score.
   - Negative marks for incorrect answers.

3. **Summary Dialog**:
   - Displays attempted, skipped, and correct questions.
   - Shows current coins and total marks.

---

## Working Demo

https://github.com/user-attachments/assets/b27beb4d-33d1-467c-8a49-84255611aac7

---

## Contributors

- [Prabhat Jana](https://github.com/iamthetwodigiter) - Developer

---

Happy Quizzing!


