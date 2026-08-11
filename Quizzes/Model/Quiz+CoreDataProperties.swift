//
//  Quiz+CoreDataProperties.swift
//  Quizzes
//
//  Created by Pham Hoang Viet on 10-08-2026.
//
//

public import Foundation
public import CoreData


public typealias QuizCoreDataPropertiesSet = NSSet

extension Quiz {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Quiz> {
        return NSFetchRequest<Quiz>(entityName: "Quiz")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var difficulty: String?
    @NSManaged public var category: String?
    @NSManaged public var questions: NSSet?
    @NSManaged public var attempts: NSSet?

}

// MARK: Generated accessors for questions
extension Quiz {

    @objc(addQuestionsObject:)
    @NSManaged public func addToQuestions(_ value: Question)

    @objc(removeQuestionsObject:)
    @NSManaged public func removeFromQuestions(_ value: Question)

    @objc(addQuestions:)
    @NSManaged public func addToQuestions(_ values: NSSet)

    @objc(removeQuestions:)
    @NSManaged public func removeFromQuestions(_ values: NSSet)

}

// MARK: Generated accessors for attempts
extension Quiz {

    @objc(addAttemptsObject:)
    @NSManaged public func addToAttempts(_ value: QuizAttempt)

    @objc(removeAttemptsObject:)
    @NSManaged public func removeFromAttempts(_ value: QuizAttempt)

    @objc(addAttempts:)
    @NSManaged public func addToAttempts(_ values: NSSet)

    @objc(removeAttempts:)
    @NSManaged public func removeFromAttempts(_ values: NSSet)

}

extension Quiz : Identifiable {

}
