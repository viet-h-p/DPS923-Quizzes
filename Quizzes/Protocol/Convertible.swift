//
//  Convertible.swift
//  Quizzes
//
//  Created by Pham Hoang Viet on 10-08-2026.
//

import CoreData

/// Protocol to provide functionality for Core Data managed object conversion.
protocol ManagedObjectConvertible {
    associatedtype ManagedObject
    
    /// Converts a conforming instance to a managed object instance.
    ///
    /// - Parameter context: The managed object context to use.
    /// - Returns: The converted managed object instance.
    func toManagedObject(in context: NSManagedObjectContext) -> ManagedObject?
}

/// Protocol to provide functionality for data model conversion.
protocol ModelConvertible {
    associatedtype Model

    /// Converts a conforming instance to a data model instance.
    ///
    /// - Returns: The converted data model instance.
    func toModel() -> Model?
}
