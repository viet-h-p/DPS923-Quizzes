//
//  AddNewQuestionView.swift
//  Quizzes
//
//  Created by Pham Hoang Viet on 05-08-2026.
//

import SwiftUI

struct AddNewQuestionView: View {
    
    @Environment(QuizzesController.self) var quizzesController
    
    @State private var title: String = ""
    
    @State private var showAlert = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var quiz: Quiz
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Question Title")
                            .font(.subheadline.bold())
                            .foregroundStyle(.gray)
                        
                        TextField("", text: $title)
                            .textFieldStyle(.roundedBorder)
                    }
                } // Section Ends
            } // Form Ends
            .navigationTitle("Add New Question")
            .navigationBarItems(trailing: Button("Add") {
                if self.quizzesController.addQuestion(quiz: quiz, questionTitle: title) {
                    self.quizzesController.fetchAllQuestions(of: quiz)
                    dismiss()
                } else {
                    self.alertTitle = "Error"
                    self.alertMessage = "Failed to add a question."
                    self.showAlert = true
                }
            })
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("\(self.alertTitle)"),
                message: Text("\(self.alertMessage)"),
                    dismissButton: .default(Text("Ok")) {
                        self.quizzesController.fetchAllQuestions(of: quiz)
                        dismiss()
                    }
                )
            } // Alert Ends
        } // NavigationStack Ends
    }
}
