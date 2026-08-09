//
//  HomeView.swift
//  Quizzes
//
//  Created by Daniel Fu on 08-08-2026.
//

import SwiftUI

// Home / Quiz Setup screen: choose the number of questions, category,
// and difficulty, then fetch questions from the API and start the quiz.
struct HomeView: View {

    @State private var quizViewModel = QuizViewModel()

    @State private var numberOfQuestions: Int = 10
    @State private var selectedCategory: TriviaCategory = .computers
    @State private var selectedDifficulty: TriviaDifficulty = .any

    @State private var isLoading: Bool = false
    @State private var showQuiz: Bool = false

    @State private var showAlert: Bool = false
    @State private var alertMessage: String = ""

    private let questionAmounts = [5, 10, 15, 20]

    var body: some View {
        NavigationStack {
            Form {
                Section("Number of Questions") {
                    Picker("Number of Questions", selection: $numberOfQuestions) {
                        ForEach(self.questionAmounts, id: \.self) { amount in
                            Text("\(amount)").tag(amount)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section("Category") {
                    Picker("Category", selection: $selectedCategory) {
                        ForEach(TriviaCategory.allCases) { category in
                            Text(category.rawValue).tag(category)
                        }
                    }
                    .pickerStyle(.menu)
                }

                Section("Difficulty") {
                    Picker("Difficulty", selection: $selectedDifficulty) {
                        ForEach(TriviaDifficulty.allCases) { difficulty in
                            Text(difficulty.rawValue).tag(difficulty)
                        }
                    }
                    .pickerStyle(.segmented)
                }

                Section {
                    Button {
                        self.startQuiz()
                    } label: {
                        HStack {
                            Spacer()
                            if(self.isLoading) {
                                ProgressView()
                            } else {
                                Text("Start Quiz")
                                    .font(.headline)
                            }
                            Spacer()
                        }
                    }
                    .disabled(self.isLoading)
                }
            } // Form Ends
            .navigationTitle("Trivia Sprint")
            .navigationDestination(isPresented: $showQuiz) {
                QuizView(quizViewModel: self.quizViewModel)
            }
            .alert("Unable to Start Quiz", isPresented: $showAlert) {
                Button("Ok", role: .cancel) {}
            } message: {
                Text(self.alertMessage)
            }
        } // NavigationStack Ends
    }

    private func startQuiz() {
        self.isLoading = true

        Task {
            do {
                let questions = try await TriviaAPIService.shared.fetchQuestions(
                    amount: self.numberOfQuestions,
                    category: self.selectedCategory.apiID,
                    difficulty: self.selectedDifficulty.apiValue
                )

                self.quizViewModel.startQuiz(questions: questions)
                self.showQuiz = true
            } catch {
                self.alertMessage = error.localizedDescription
                self.showAlert = true
            }

            self.isLoading = false
        }
    }
}

#Preview {
    HomeView()
}
