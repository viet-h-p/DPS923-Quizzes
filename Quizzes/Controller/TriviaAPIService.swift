//
//  TriviaAPIService.swift
//  Quizzes
//
//  Created by Daniel Fu on 08-08-2026.
//

import Foundation

enum TriviaAPIError: Error, LocalizedError {
    case invalidURL
    case requestFailed
    case noResults
    case apiError(code: Int)

    var errorDescription: String? {
        switch self {
        case .invalidURL:
            return "The API URL could not be built."
        case .requestFailed:
            return "The network request failed."
        case .noResults:
            return "The API returned no questions."
        case .apiError(let code):
            switch code {
            case 1:
                return "Not enough questions available for these settings. Try fewer questions or a different difficulty."
            case 5:
                return "Too many requests. Please wait a few seconds and try again."
            default:
                return "The API returned an error (response_code: \(code))."
            }
        }
    }
}

class TriviaAPIService {
    static let shared = TriviaAPIService()

    private let baseURL = "https://opentdb.com/api.php"

    private init() {}

    // Fetches multiple-choice questions from the Open Trivia Database.
    // Example: https://opentdb.com/api.php?amount=10
    // category and difficulty are optional; when nil, the API mixes everything.
    func fetchQuestions(amount: Int, category: Int? = nil, difficulty: String? = nil) async throws -> [TriviaQuestion] {
        var components = URLComponents(string: self.baseURL)

        var queryItems = [
            URLQueryItem(name: "amount", value: String(amount)),
            URLQueryItem(name: "type", value: "multiple"),
            // Ask the API to percent-encode all text so we can safely decode
            // it with removingPercentEncoding (see TriviaQuestion)
            URLQueryItem(name: "encode", value: "url3986")
        ]

        if let category {
            queryItems.append(URLQueryItem(name: "category", value: String(category)))
        }

        if let difficulty {
            queryItems.append(URLQueryItem(name: "difficulty", value: difficulty.lowercased()))
        }

        components?.queryItems = queryItems

        guard let url = components?.url else {
            throw TriviaAPIError.invalidURL
        }

        let (data, response) = try await URLSession.shared.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw TriviaAPIError.requestFailed
        }

        let triviaResponse = try JSONDecoder().decode(TriviaResponse.self, from: data)

        // response_code 0 means success; anything else is an API-side problem
        // (1 = not enough questions, 2 = invalid parameter, 5 = rate limited, ...)
        guard triviaResponse.responseCode == 0 else {
            throw TriviaAPIError.apiError(code: triviaResponse.responseCode)
        }

        guard !triviaResponse.results.isEmpty else {
            throw TriviaAPIError.noResults
        }

        print("\(triviaResponse.results.count) trivia questions fetched...")
        return triviaResponse.results
    }
}
