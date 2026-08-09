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
            TabView {
                HomeView()
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }

                QuizzesHistoryView()
                    .tabItem {
                        Label("History", systemImage: "clock")
                    }
            }
            .environment(quizzesController)
        }
    }
}
