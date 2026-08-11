//
//  IncorrectAnswer+CoreDataProperties.swift
//  Quizzes
//
//  Created by Pham Hoang Viet on 10-08-2026.
//
//

public import Foundation
public import CoreData


public typealias IncorrectAnswerCoreDataPropertiesSet = NSSet

extension IncorrectAnswer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<IncorrectAnswer> {
        return NSFetchRequest<IncorrectAnswer>(entityName: "IncorrectAnswer")
    }

    @NSManaged public var answer: String?
    @NSManaged public var question: Question?

}

extension IncorrectAnswer : Identifiable {

}
