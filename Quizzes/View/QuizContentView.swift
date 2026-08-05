//
//  QuizContentView.swift
//  Quizzes
//
//  Created by Pham Hoang Viet on 05-08-2026.
//

import SwiftUI

struct QuizContentView: View {
    
    @Environment(QuizzesController.self) var quizzesController
    
    @State private var showAddQuestion: Bool = false
    
    @Environment(\.dismiss) private var dismiss
    
    var quiz: Quiz
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(self.quizzesController.questions) { question in
                    Text(question.title ?? "No Title")
                        .font(.headline)
                }
            }
        }
        .navigationTitle(quiz.title!)
        .navigationBarItems(trailing: Button("Add Question") {
            self.showAddQuestion.toggle()
        })
        .sheet(isPresented: $showAddQuestion) {
            AddNewQuestionView(quiz: quiz)
        }
        .onAppear() {
            self.quizzesController.fetchAllQuestions(of: quiz)
        }
    }
}
