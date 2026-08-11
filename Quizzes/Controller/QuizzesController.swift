//
//  QuizzesController.swift
//  Quizzes
//
//  Created by Pham Hoang Viet on 04-08-2026.
//

import Foundation
import CoreData

@Observable
class QuizzesController {
    private let viewContext = PersistanceController.shared.container.viewContext
    
    var quizzes: [Quiz] = []
    
    private let ENTITY_QUIZ = "Quiz"
    private let ENTITY_QUIZ_ATTEMPT = "QuizAttempt"
    private let ENTITY_QUESTION = "Question"
    private let ENTITY_INCORRECT_ANSWER = "IncorrectAnswer"
    
    private static var shared: QuizzesController?
    
    static func getInstance() -> QuizzesController {
        if(self.shared == nil) {
            shared = QuizzesController()
        }
        
        return shared!
    }
    
    private func saveContext() -> Bool {
        // check if there are any unsaved changes with viewContext
        guard self.viewContext.hasChanges else {
            return false
        }
        
        do {
            try self.viewContext.save()
            print(("Data saved successfully"))
            return true
        } catch {
            print("Unable to save data...\(error.localizedDescription)")
            return false
        }
    }
    
    func fetchAllQuizzes() {
        self.quizzes.removeAll()
        let request: NSFetchRequest<Quiz> = Quiz.fetchRequest()
        
        // SELECT * FROM Quiz ORDER BY name ASC
//        quizRequest.sortDescriptors = [NSSortDescriptor(key: "name", ascending: true)]
        
        do {
            self.quizzes = try self.viewContext.fetch(request)
            print("\(self.quizzes.count) quizzes found...")
        } catch {
            print("Unable to fetch quizzes... \(error.localizedDescription)")
        }
    }
    
    func createQuiz(category: String, difficulty: String, questions: [Question?]) -> Quiz? {
        let newQuiz = NSEntityDescription.insertNewObject(forEntityName: ENTITY_QUIZ, into: self.viewContext) as! Quiz
        let quizId = UUID()
        newQuiz.id = quizId
        newQuiz.title = "Quiz"
        newQuiz.category = category
        newQuiz.difficulty = difficulty
        
        questions.forEach { question in
            newQuiz.addToQuestions(question!)
        }
        
        if saveContext() {
            return newQuiz
        } else {
            return nil
        }
    }
    
    func addQuizAttempt(quiz: Quiz, score: Int, totalQuestions: Int) -> Bool {
        let attempt = NSEntityDescription.insertNewObject(forEntityName: ENTITY_QUIZ_ATTEMPT, into: self.viewContext) as! QuizAttempt
        attempt.id = UUID()
        attempt.dateTaken = Date()
        attempt.score = Int16(score)
        attempt.totalQuestions = Int16(totalQuestions)
        attempt.quiz = quiz
        return saveContext()
    }
    
    func deleteQuiz(_ quizToDelete: Quiz) -> Bool {
        self.viewContext.delete(quizToDelete)
        return saveContext()
    }
}
