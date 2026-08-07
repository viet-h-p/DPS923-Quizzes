//
//  AddNewQuizView.swift
//  Quizzes
//
//  Created by Pham Hoang Viet on 05-08-2026.
//

import SwiftUI

struct AddNewQuizView: View {
    
    @Environment(QuizzesController.self) var quizzesController
    
    @State private var title: String = ""
//    @State private var score: String = ""
    
    @State private var showAlert = false
    @State private var alertTitle: String = ""
    @State private var alertMessage: String = ""
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    VStack(alignment: .leading, spacing: 10) {
                        Text("Quiz Title")
                            .font(.subheadline.bold())
                            .foregroundStyle(.gray)
                        
                        TextField("", text: $title)
                            .textFieldStyle(.roundedBorder)
                    }
                    
//                    VStack(alignment: .leading, spacing: 10) {
//                        Text("Quiz Score")
//                            .font(.subheadline.bold())
//                            .foregroundStyle(.gray)
//                        
//                        TextField("", text: $score)
//                            .textFieldStyle(.roundedBorder)
//                    }
                } // Section Ends
            } // Form Ends
            .navigationTitle("Add New Quiz")
            .navigationBarItems(trailing: Button("Add") {
                if self.quizzesController.addQuiz(quizTitle: self.title, score: 0, maxScore: 10) {
                    self.quizzesController.fetchAllQuizzes()
                    dismiss()
                } else {
                    self.alertTitle = "Error"
                    self.alertMessage = "Failed to add a quiz."
                    self.showAlert = true
                }
            })
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("\(self.alertTitle)"),
                message: Text("\(self.alertMessage)"),
                    dismissButton: .default(Text("Ok")) {
                        self.quizzesController.fetchAllQuizzes()
                        dismiss()
                    }
                )
            } // Alert Ends
        } // NavigationStack Ends
    }
}
