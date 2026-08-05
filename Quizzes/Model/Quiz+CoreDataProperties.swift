//
//  Quiz+CoreDataProperties.swift
//  Quizzes
//
//  Created by Pham Hoang Viet on 05-08-2026.
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
    @NSManaged public var maxScore: Int16
    @NSManaged public var score: Int16
    @NSManaged public var title: String?
    @NSManaged public var dateTaken: Date?
    @NSManaged public var questions: NSSet?

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

extension Quiz : Identifiable {

}
