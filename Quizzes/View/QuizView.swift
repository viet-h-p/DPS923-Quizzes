//
//  QuizView.swift
//  Quizzes
//
//  Created by Daniel Fu on 08-08-2026.
//

import SwiftUI

// Placeholder for the Quiz screen. The QuizViewModel arrives already
// loaded with fetched questions (startQuiz has been called), so the real
// quiz UI only needs to be built inside this view's body.
struct QuizView: View {

    var quizViewModel: QuizViewModel

    var body: some View {
        VStack(spacing: 20) {
            ProgressView(value: self.quizViewModel.progress)

            Text("Question \(self.quizViewModel.currentQuestionIndex + 1) of \(self.quizViewModel.questions.count)")
                .font(.headline)

            Text(self.quizViewModel.currentQuestion?.question ?? "No question loaded")
                .font(.title3)
                .multilineTextAlignment(.center)

            Text("Quiz screen UI goes here...")
                .foregroundStyle(.gray)

            Spacer()
        }
        .padding()
        .navigationTitle("Quiz")
        .navigationBarTitleDisplayMode(.inline)
    }
}
