//
//  TriviaOptions.swift
//  Quizzes
//
//  Created by Daniel Fu on 08-08-2026.
//

import Foundation

// Categories offered on the Quiz Setup screen, mapped to the
// Open Trivia DB category ids (https://opentdb.com/api_category.php)
enum TriviaCategory: String, CaseIterable, Identifiable {
    case any = "Any Category"
    case computers = "Science: Computers"
    case mathematics = "Science: Mathematics"
    case scienceNature = "Science & Nature"
    case generalKnowledge = "General Knowledge"
    case videoGames = "Video Games"
    case history = "History"
    case geography = "Geography"

    var id: String {
        return self.rawValue
    }

    // The category id used by the API; nil means no category filter
    var apiID: Int? {
        switch self {
        case .any: return nil
        case .computers: return 18
        case .mathematics: return 19
        case .scienceNature: return 17
        case .generalKnowledge: return 9
        case .videoGames: return 15
        case .history: return 23
        case .geography: return 22
        }
    }
}

enum TriviaDifficulty: String, CaseIterable, Identifiable {
    case any = "Any"
    case easy = "Easy"
    case medium = "Medium"
    case hard = "Hard"

    var id: String {
        return self.rawValue
    }

    // The value used by the API; nil means no difficulty filter
    var apiValue: String? {
        if(self == .any) {
            return nil
        }
        return self.rawValue.lowercased()
    }
}
