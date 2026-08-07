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
    var questions: [Question] = []
    
    private let ENTITY_QUIZ = "Quiz"
    private let ENTITY_QUESTION = "Question"
    
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
    
    func addQuiz(quizTitle: String, score: Int, maxScore: Int) -> Bool {
        
        let newQuiz = NSEntityDescription.insertNewObject(forEntityName: ENTITY_QUIZ, into: self.viewContext) as! Quiz
        newQuiz.id = UUID()
        newQuiz.title = quizTitle
        newQuiz.dateTaken = Date()
        newQuiz.maxScore = Int16(maxScore)
        newQuiz.score = Int16(score)
        
        return saveContext()
    }
    
    func fetchAllQuestions(of quiz: Quiz) {
        let request: NSFetchRequest<Question> = Question.fetchRequest()
        
        // SELECT * FROM Question WHERE quiz = quiz
        request.predicate = NSPredicate(format: "quiz == %@", quiz)
        
//        request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true)]
        
        do {
            self.questions = try self.viewContext.fetch(request)
            print("\(self.questions.count) questions found...")
        } catch {
            print("Unable to fetch questions... \(error.localizedDescription)")
        }
    }
    
    func addQuestion(quiz: Quiz, questionTitle: String) -> Bool {
        
        let newQuestion = NSEntityDescription.insertNewObject(forEntityName: ENTITY_QUESTION, into: self.viewContext) as! Question
        newQuestion.id = UUID()
        newQuestion.title = questionTitle
        newQuestion.answerCorrect = false
        newQuestion.quiz = quiz
        
        return saveContext()
    }
    
    func deleteQuiz(_ quizToDelete: Quiz) -> Bool {
        self.viewContext.delete(quizToDelete)
        return saveContext()
    }
}
