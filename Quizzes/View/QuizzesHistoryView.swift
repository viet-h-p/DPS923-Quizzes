//
//  QuizzesHistoryView.swift
//  Quizzes
//
//  Created by Pham Hoang Viet on 05-08-2026.
//

import SwiftUI
import CoreData

struct QuizzesHistoryView: View {
    @Environment(QuizzesController.self) var quizzesController
    
    @State private var showAlert = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        NavigationStack {
            if self.quizzesController.quizzes.isEmpty {
                VStack {
                    Text("No Quiz found!")
                }
            } else {
                List {
                    ForEach(self.quizzesController.quizzes) { quiz in
                        QuizRow(quiz: quiz)
                    }
                    .onDelete(perform: deleteItems)
                }
                .navigationTitle("My Quizzes")
                .navigationBarTitleDisplayMode(.inline)
                .alert(isPresented: $showAlert) {
                    Alert(
                        title: Text("\(self.alertTitle)"),
                        message: Text("\(self.alertMessage)"),
                        dismissButton: .default(Text("Ok")) {
                            dismiss()
                        }
                    )
                } // Alert Ends
            }
        } // NavigationStack Ends
        .onAppear() {
            self.quizzesController.fetchAllQuizzes()
        }
    }
    
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                let quizToDelete = self.quizzesController.quizzes[index]
                
                if self.quizzesController.deleteQuiz(quizToDelete) {
                    self.quizzesController.quizzes.remove(at: index)
                } else {
                    self.alertTitle = "Error"
                    self.alertMessage = "Failed to delete \(quizToDelete.title!)."
                    self.showAlert = true
                }
            }
        }
    }
}
