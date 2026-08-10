//
//  Question+CoreDataProperties.swift
//  Quizzes
//
//  Created by Pham Hoang Viet on 10-08-2026.
//
//

public import Foundation
public import CoreData


public typealias QuestionCoreDataPropertiesSet = NSSet

extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var correctAnswer: String?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var type: String?
    @NSManaged public var difficulty: String?
    @NSManaged public var category: String?
    @NSManaged public var quiz: Quiz?
    @NSManaged public var incorrectAnswers: NSSet?

}

// MARK: Generated accessors for incorrectAnswers
extension Question {

    @objc(addIncorrectAnswersObject:)
    @NSManaged public func addToIncorrectAnswers(_ value: IncorrectAnswer)

    @objc(removeIncorrectAnswersObject:)
    @NSManaged public func removeFromIncorrectAnswers(_ value: IncorrectAnswer)

    @objc(addIncorrectAnswers:)
    @NSManaged public func addToIncorrectAnswers(_ values: NSSet)

    @objc(removeIncorrectAnswers:)
    @NSManaged public func removeFromIncorrectAnswers(_ values: NSSet)

}

extension Question : Identifiable {

}
