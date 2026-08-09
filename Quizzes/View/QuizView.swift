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
    
    @State private var showResult: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            ProgressView(value: self.quizViewModel.progress)

            Text("Question \(self.quizViewModel.currentQuestionIndex + 1) of \(self.quizViewModel.questions.count)")
                .font(.headline)

            Text(self.quizViewModel.currentQuestion?.question ?? "No question loaded")
                .font(.title3)
                .multilineTextAlignment(.center)

            ForEach(self.quizViewModel.shuffledAnswers, id: \.self){
                answer in
                Button {
                    self.quizViewModel.selectAnswer(answer)
                } label: {
                    Text(answer)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(
                            self.quizViewModel.selectedAnswer == answer
                            ? (
                                answer == self.quizViewModel.currentQuestion?.correctAnswer
                                ? Color.green.opacity(0.4)
                                : Color.red.opacity(0.4)
                            )
                            : Color.blue.opacity(0.15)
                        )
                        .cornerRadius(10)
                }
                .buttonStyle(.plain)
                .disabled(self.quizViewModel.hasAnswered)
            }
            
            if(self.quizViewModel.hasAnswered) {
                Button {
                    let movedToNextQuestion =
                        self.quizViewModel.moveToNextQuestion()
                    
                    if(!movedToNextQuestion
                       && self.quizViewModel.isQuizCompleted) {
                        self.showResult = true
                    }
                } label: {
                    Text(
                        self.quizViewModel.isLastQuestion
                        ? "View Results"
                        : "Next Question"
                    )
                    .frame(maxWidth: .infinity)
                    .padding()
                }
                .buttonStyle(.borderedProminent)
            }

            Spacer()
        }
        .padding()
        .navigationTitle("Quiz")
        .navigationBarTitleDisplayMode(.inline)
        .navigationDestination(isPresented: $showResult){
            ResultView(quizViewModel: self.quizViewModel)
        }
    }
}
