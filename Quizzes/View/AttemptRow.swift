//
//  AttemptRow.swift
//  Quizzes
//
//  Created by Pham Hoang Viet on 10-08-2026.
//

import SwiftUI

struct AttemptRow: View {
    let attempt: QuizAttempt
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(attempt.dateTaken ?? Date(),
                     format: .dateTime
                    .month()
                    .day()
                    .year()
                    .hour()
                    .minute())
                .font(.subheadline)
                
                Text("\(attempt.totalQuestions) questions")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            Text("Score: \(attempt.score)")
                .font(.headline)
        }
        .padding(.vertical, 4)
    }
}
