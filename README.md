# Trivia Sprint 🏁

**A Swift computer science quiz application**
DPS923NSA Final Project — Group 11: Jiseok Shim, Viet Pham, and Daniel Fu

Trivia Sprint is an iOS app that provides short computer science quizzes using JSON data retrieved from the [Open Trivia Database](https://opentdb.com/) Web API. Users select the number of questions, category, and difficulty level, answer multiple-choice questions, review their results, and save their quiz history with Core Data.

With a focus on the **Science: Computers** category — covering programming, computer hardware, networking, operating systems, and technology history — Trivia Sprint serves as a convenient study tool for computer science students who want to review and strengthen their foundational knowledge.

## Purpose

The app helps users quickly review fundamental computer science topics and measure their performance. Short quizzes with immediate results let users understand their current level of knowledge and identify topics that need additional study. By saving previous quiz results, users can compare scores, observe their improvement over time, and attempt quizzes at different difficulty levels — supporting preparation for future technical discussions and interviews.

## Features

- **Custom quiz setup** — choose the number of questions (5–20), category (with emphasis on Science: Computers), and difficulty (Easy / Medium / Hard / Any)
- **Live trivia questions** — fetched on demand from the Open Trivia DB API (no API key required)
- **Interactive quiz play** — answer choices are shuffled per question, with instant color-coded feedback (green = correct, red = wrong), the current question number (e.g. "Question 3 of 10"), and a progress bar
- **Results summary** — final score, percentage, and correct/incorrect breakdown, with the option to retry the same quiz
- **Quiz history** — every attempt is saved locally with Core Data, showing the category, difficulty, date, and score; swipe to delete old records

## App Flow

```
Home (Quiz Setup) → Fetch Questions from API → Quiz Play → Results → Saved to Core Data → History
```

## Screens

| Screen | Description |
|--------|-------------|
| **Home / Quiz Setup** | Pickers for question count, category, and difficulty; starts the quiz |
| **Quiz** | One question at a time with four shuffled choices, question counter, progress bar, and answer feedback |
| **Results** | Score, percentage, correct/incorrect counts, and a retry button |
| **History** | List of past quizzes and attempts stored in Core Data, with swipe-to-delete |
| **Review** *(stretch goal)* | Shows incorrectly answered questions alongside the correct answers — added if time allows after the core four screens |

## Architecture

The app follows an **MVVM** structure with a Core Data persistence layer:

- **Model** — `TriviaQuestion` Codable structs decode the OpenTDB JSON response; Core Data entities (`Quiz`, `Question`, `IncorrectAnswer`, `QuizAttempt`) persist quizzes and results. A `ManagedObjectConvertible` protocol bridges API models to managed objects.
- **View** — SwiftUI views (`HomeView`, `QuizView`, `ResultView`, `QuizzesHistoryView`) organized in a tab bar (Home + History), with `NavigationStack` driving the quiz flow.
- **ViewModel** — `QuizViewModel` (`@Observable`) owns the quiz state: current question, shuffled answers, scoring, progress, and completion.
- **Controller / Service** — `TriviaAPIService` handles API calls with async/await; `QuizzesController` manages Core Data fetches and saves; `PersistanceController` wraps the Core Data stack.

### API Integration

Questions come from `https://opentdb.com/api.php` with configurable `amount`, `category`, and `difficulty` parameters. The service requests URL-encoded text (`encode=url3986`) and decodes it during JSON parsing, cleanly avoiding HTML-entity issues in question text. API error codes (rate limiting, not enough questions) are translated into user-friendly alerts.

## Technology

| Layer | Technology |
|-------|------------|
| UI | SwiftUI (Observation framework, `TabView`) |
| Navigation | `NavigationStack` |
| Persistence | Core Data |
| Networking | URLSession with async/await |
| Data source | Open Trivia Database REST API (JSON) |

## Getting Started

1. Clone the repository
2. Open `Quizzes/Quizzes.xcodeproj` in Xcode 26 or later
3. Build and run on an iOS simulator or device — no API key or additional setup needed

## Team & Work Distribution

Responsibilities are grouped so that each member owns a complete vertical slice of the app, while all members collaborate on integration and testing.

| Team Member | Responsibilities |
|-------------|------------------|
| **Daniel Fu** | Home / Quiz Setup screen; API integration — JSON models (Codable structs) and the API service layer for fetching questions from OpenTDB |
| **Jiseok Shim** | Quiz and Results screens; quiz logic and ViewModel (question flow, scoring, progress tracking) |
| **Viet Pham** | Core Data entities and persistence layer; Quiz History screen; Review screen (stretch goal) |
