//
//  QuizzesHistoryView.swift
//  Quizzes
//
//  Created by Pham Hoang Viet on 05-08-2026.
//

import SwiftUI

struct QuizzesHistoryView: View {
    @Environment(QuizzesController.self) var quizzesController
    
    @State private var showAddQuiz: Bool = false
    
    @State private var showAlert = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(self.quizzesController.quizzes) { quiz in
                    NavigationLink(destination: QuizContentView(quiz: quiz)) {
                        HStack {
                            Text(quiz.title ?? "Unknown")
                                .font(.headline)
                            Spacer()
                            Text("Taken on \(quiz.dateTaken ?? Date(), formatter: dateFormatter)")
                        }
                    }
                }
                .onDelete(perform: deleteItems)
            } // List Ends
            .navigationTitle("Quizzes")
            .navigationBarTitleDisplayMode(.inline)
            .navigationBarItems(trailing: Button("Add Quiz") {
                self.showAddQuiz.toggle()
            })
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("\(self.alertTitle)"),
                message: Text("\(self.alertMessage)"),
                    dismissButton: .default(Text("Ok")) {
                        dismiss()
                    }
                )
            } // Alert Ends
            .sheet(isPresented: $showAddQuiz) {
                AddNewQuizView()
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

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()
