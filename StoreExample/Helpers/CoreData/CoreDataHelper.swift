//
//  CoreDataHelper.swift
//  StoreExample
//
//  Created by Alper KARATAS on 10/23/18.
//  Copyright © 2018 Alper KARATAS. All rights reserved.
//

import Foundation
import CoreData

// Core Data Custom Errors
public enum CoreDataError: Error, CustomStringConvertible, Equatable {
    case entityNotfound(name: String)
    case fetchError(errorDesc: String)
    case saveError(errorDesc: String)
    case deleteError(errorDesc: String)

    public var description: String {
        return "CoreDataError: \(caseDescription)"
    }

    var caseDescription: String {
        switch self {
        case .entityNotfound(name: let name): return "Entity \(name) not found."
        case .fetchError(errorDesc: let errorDesc): return "FetchError \(errorDesc)"
        case .saveError(errorDesc: let errorDesc): return "SaveError \(errorDesc)"
        case .deleteError(errorDesc: let errorDesc): return "SaveError \(errorDesc)"
        }
    }

    public static func ==(lhs: CoreDataError, rhs: CoreDataError) -> Bool {
        switch (lhs, rhs) {
        case (let .entityNotfound(str1), let .entityNotfound(str2)):
            return str1 == str2
        case (let .fetchError(str1), let .fetchError(str2)):
            return str1 == str2
        case (let .saveError(str1), let .saveError(str2)):
            return str1 == str2
        case (let .deleteError(str1), let .deleteError(str2)):
            return str1 == str2
        default:
            return false
        }
    }
}

// Persistent Container
var persistentContainer: NSPersistentContainer = {
    let container = NSPersistentContainer(name: "Store")
    container.loadPersistentStores(completionHandler: { _, error in
        if let error = error as NSError? {
            fatalError("Unresolved error \(error), \(error.userInfo)")
        }
    })
    return container
}()

// Generic Create function
func create<I: NSManagedObject>(type: I.Type) throws -> I {
    let className = String(describing: I.self)
    let container = persistentContainer
    if let entity = NSEntityDescription.entity(forEntityName: className, in: container.viewContext) {
        return NSManagedObject.init(entity: entity, insertInto: container.viewContext) as! I
    } else {
        throw CoreDataError.entityNotfound(name: className)
    }
}

// Generic Select Function
func select<I: NSManagedObject>(type: I.Type, request: NSFetchRequest<NSManagedObject>) throws -> [I] {
    do {
        return try persistentContainer.viewContext.fetch(request) as! [I]
    } catch let error {
        throw CoreDataError.fetchError(errorDesc: error.localizedDescription)
    }
}

// Generic Read All Function
func selectAll<I: NSManagedObject>(type: I.Type) throws -> [I] {
    let className = NSStringFromClass(I.self)
    let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: className)
    return try select(type: I.self, request: fetchRequest)
}

// Save Function
func toSaveContext() throws {
    let context = persistentContainer.viewContext
    context.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
    if context.hasChanges {
        do {
            try context.save()
        } catch {
            throw CoreDataError.saveError(errorDesc: error.localizedDescription)
        }
    }
}

//  Delete Function
func delete(object: NSManagedObject) {
    persistentContainer.viewContext.delete(object)
}

// Delete All Function

func deleteAll<I: NSManagedObject>(type: I.Type) throws {
    do {
        let allObjects = try selectAll(type: I.self)
        for object in allObjects {
            delete(object: object)
        }
        try toSaveContext()
    } catch {
        throw error
    }

}
