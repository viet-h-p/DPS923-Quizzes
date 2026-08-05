//
//  Question+CoreDataProperties.swift
//  Quizzes
//
//  Created by Pham Hoang Viet on 05-08-2026.
//
//

public import Foundation
public import CoreData


public typealias QuestionCoreDataPropertiesSet = NSSet

extension Question {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Question> {
        return NSFetchRequest<Question>(entityName: "Question")
    }

    @NSManaged public var answerCorrect: Bool
    @NSManaged public var title: String?
    @NSManaged public var id: UUID?
    @NSManaged public var quiz: Quiz?

}

extension Question : Identifiable {

}
