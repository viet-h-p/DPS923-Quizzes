//
//  QuizAttempt+CoreDataProperties.swift
//  Quizzes
//
//  Created by Pham Hoang Viet on 10-08-2026.
//
//

public import Foundation
public import CoreData


public typealias QuizAttemptCoreDataPropertiesSet = NSSet

extension QuizAttempt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<QuizAttempt> {
        return NSFetchRequest<QuizAttempt>(entityName: "QuizAttempt")
    }

    @NSManaged public var dateTaken: Date?
    @NSManaged public var score: Int16
    @NSManaged public var totalQuestions: Int16
    @NSManaged public var id: UUID?
    @NSManaged public var quiz: Quiz?

}

extension QuizAttempt : Identifiable {

}
