//
//  TriviaQuestion.swift
//  Quizzes
//
//  Created by Daniel Fu on 08-08-2026.
//

import Foundation

// Top-level response from the Open Trivia Database API
// https://opentdb.com/api.php
struct TriviaResponse: Codable {
    let responseCode: Int
    let results: [TriviaQuestion]

    enum CodingKeys: String, CodingKey {
        case responseCode = "response_code"
        case results
    }
}

// A single multiple-choice question from the API
struct TriviaQuestion: Codable, Identifiable {
    let id = UUID()

    let type: String
    let difficulty: String
    let category: String
    let question: String
    let correctAnswer: String
    let incorrectAnswers: [String]

    enum CodingKeys: String, CodingKey {
        case type
        case difficulty
        case category
        case question
        case correctAnswer = "correct_answer"
        case incorrectAnswers = "incorrect_answers"
    }

    // We request the API with "encode=url3986", so every text field arrives
    // percent-encoded (e.g. "What%27s..."). Decode it back to plain text here
    // instead of dealing with HTML entities like &quot; and &#039;.
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        self.type = try container.decode(String.self, forKey: .type).percentDecoded
        self.difficulty = try container.decode(String.self, forKey: .difficulty).percentDecoded
        self.category = try container.decode(String.self, forKey: .category).percentDecoded
        self.question = try container.decode(String.self, forKey: .question).percentDecoded
        self.correctAnswer = try container.decode(String.self, forKey: .correctAnswer).percentDecoded
        self.incorrectAnswers = try container.decode([String].self, forKey: .incorrectAnswers).map { $0.percentDecoded }
    }
}

private extension String {
    var percentDecoded: String {
        return self.removingPercentEncoding ?? self
    }
}
