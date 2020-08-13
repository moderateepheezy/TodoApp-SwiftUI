//
//  CoreDataPersistenceManager.swift
//  TodoApp
//
//  Created by Afees Lawal on 05/08/2020.
//

import Foundation
import UIKit
import CoreData

final class CoreDataPersistenceManager: PersistenceManager {

    typealias ObjectType = NSManagedObject

    typealias PredicateType = NSPredicate

    var context: NSManagedObjectContext { persistentContainer.viewContext }

    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TodoApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    init() {
        let notificationCenter = NotificationCenter.default
        let notification = UIApplication.willResignActiveNotification
        notificationCenter.addObserver(forName: notification, object: nil, queue: nil) { [weak self] _ in
          guard let self = self else { return }

          if self.persistentContainer.viewContext.hasChanges {
            try? self.persistentContainer.viewContext.save()
          }
        }
    }

    func create(_ object: NSManagedObject) {
        do {
            try context.save()
        } catch {
            fatalError("error savingcontext")
        }
    } 

    func fetch<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate? = nil, limit: Int? = nil) -> Result<[T], Error> {
        let fetchRequest = NSFetchRequest<TodoMO>(entityName: "TodoMO")
        fetchRequest.predicate = predicate

        if let limit = limit {
            fetchRequest.fetchLimit = limit
        }

        do {
            let result = try context.fetch(fetchRequest)
            return .success(result as? [T] ?? [])
        } catch {
            return .failure(error)
        }
    }

    func fetchFirst<T: NSManagedObject>(_ objectType: T.Type, predicate: NSPredicate?) -> Result<T?, Error> {
        let result = fetch(objectType, predicate: predicate, limit: 1)
        switch result {
        case .success(let todos):
            return .success(todos.first)
        case .failure(let error):
            return .failure(error)
        }
    }

    func update(_ object: NSManagedObject) {
        do {
            try context.save()
        } catch {
            fatalError("error saving context while updating an object")
        }
    }

    func delete(_ object: NSManagedObject) {
        context.delete(object)
    }
}
