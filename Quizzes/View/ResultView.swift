//
//  ResultView.swift
//  Quizzes
//
//  Created by Jiseok Shim on 2026-08-06.
//

import SwiftUI

struct ResultView: View {
    
    var quizViewModel: QuizViewModel
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack(spacing: 20){
            
            Text("Quiz Completed!")
                .font(.largeTitle)
                .fontWeight(.bold)
            
            Text("\(self.quizViewModel.percentage)%")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundStyle(.blue)
            
            Text("Score: \(self.quizViewModel.score) of \(self.quizViewModel.questions.count)")
                .font(.title2)
            
            HStack(spacing: 20) {
                VStack{
                    Text("\(self.quizViewModel.correctCount)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.green)
                    Text("Correct")
                        .font(.headline)
                }.frame(maxWidth: .infinity)
                    .padding()
                    .background(.green.opacity(0.15))
                    .cornerRadius(10)
                
                VStack{
                    Text("\(self.quizViewModel.incorrectCount)")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.red)
                    
                    Text("Incorrect")
                        .font(.headline)
                }.frame(maxWidth: .infinity)
                    .padding()
                    .background(.red.opacity(0.15))
                    .cornerRadius(10)
            }
            
            Button{
                self.quizViewModel.restartQuiz()
                self.dismiss()
            }label: {
                Text("Retry Same Quiz")
                    .frame(maxWidth: .infinity)
                    .padding()
            }.buttonStyle(.borderedProminent)
            
            Spacer()
        }
        .padding()
        .navigationTitle("Results")
        .navigationBarTitleDisplayMode(.inline)
    }
}
