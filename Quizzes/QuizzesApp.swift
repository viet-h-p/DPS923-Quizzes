//
//  QuizzesApp.swift
//  Quizzes
//
//  Created by Pham Hoang Viet on 04-08-2026.
//

import SwiftUI

@main
struct QuizzesApp: App {
    @State private var quizzesController = QuizzesController.getInstance()

    var body: some Scene {
        WindowGroup {
            QuizzesHistoryView()
                .environment(quizzesController)
        }
    }
}
