//
//  PersistenceController.swift
//  Quizzes
//
//  Created by Pham Hoang Viet on 04-08-2026.
//

import CoreData

@Observable
class PersistanceController {
    static let shared = PersistanceController()
    
    // Instance of the CoreData Container
    let container: NSPersistentContainer
    
    private init() {
        self.container = NSPersistentContainer(name: "Quizzes")
        
        // Load any persistance store; create a store if none exists
        self.container.loadPersistentStores { description, error in
            if let error {
                print("Unable to access Quizzes... \(error.localizedDescription)")
            }
            
            print("Quizzes Loaded... \(description)")
        }
    }
}
