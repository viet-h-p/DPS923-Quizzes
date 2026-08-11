//
//  QuizRow.swift
//  Quizzes
//
//  Created by Pham Hoang Viet on 10-08-2026.
//

import SwiftUI

struct QuizRow: View {
    let quiz: Quiz
    @State private var isExpanded = false

    var attempts: [QuizAttempt] {
        let attempts = quiz.attempts as? Set<QuizAttempt> ?? []

        return attempts.sorted {
            ($0.dateTaken ?? .distantPast) >
            ($1.dateTaken ?? .distantPast)
        }
    }

    var bestScore: Int {
        Int(attempts.map { $0.score }.max() ?? 0)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {

            // Quiz header
            Button {
                withAnimation {
                    isExpanded.toggle()
                }
            } label: {
                HStack {
                    VStack(alignment: .leading, spacing: 5) {
                        Text(quiz.title ?? "Untitled Quiz")
                            .font(.headline)
                            .foregroundStyle(.primary)

                        HStack {
                            Text(quiz.category ?? "Unknown")
                            Text("•")
                            Text(quiz.difficulty ?? "Unknown")
                        }
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    }

                    Spacer()

                    VStack(alignment: .trailing) {
                        Text("\(attempts.count)")
                            .font(.headline)

                        Text(attempts.count == 1 ? "Attempt" : "Attempts")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                    }

                    Image(systemName: isExpanded
                          ? "chevron.up"
                          : "chevron.down")
                        .font(.caption)
                }
            }
            .buttonStyle(.plain)

            // Attempts
            if isExpanded {
                Divider()

                if attempts.isEmpty {
                    Text("No attempts yet")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(attempts) { attempt in
                        AttemptRow(attempt: attempt)
                    }
                }
            }
        }
        .padding(.vertical, 6)
    }
}
