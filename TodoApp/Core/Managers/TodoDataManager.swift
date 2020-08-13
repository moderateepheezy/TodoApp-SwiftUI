//
//  TodoDataManager.swift
//  TodoApp
//
//  Created by Afees Lawal on 13/08/2020.
//

import Foundation
import CoreData

final class TodoDataManager: ObservableObject {

    var onUpdate: (() -> Void)? = nil

    private let persistentManager = CoreDataPersistenceManager()

    private let notificationManager: LocalNotificationManager

    init(notificationManager: LocalNotificationManager = LocalNotificationManager.shared) {
        self.notificationManager = notificationManager
        authorizeLocalNotification()
    }

    private func authorizeLocalNotification() {
        notificationManager.requestAuthorization { error in
            print("Authorization result: \(String(describing: error))")
        }
    }

    private func getTodoMO(for todo: Todo) -> TodoMO? {
        let predicate = NSPredicate(format: "uuid = %@", todo.id as CVarArg)
        let result = persistentManager.fetchFirst(TodoMO.self, predicate: predicate)
        switch result {
        case .success(let todoMO):
            return todoMO
        case .failure(_):
            return nil
        }
    }
}

extension TodoDataManager: DataManager {
    func fetchTodoList() -> [Todo] {
        let result: Result<[TodoMO], Error> = persistentManager.fetch(TodoMO.self, predicate: nil)
        switch result {
        case .success(let todoMO):
            return todoMO.map { $0.todoModel() }
        case .failure(_):
            return []
        }
    }

    func add(todo: Todo) {
        let entity =  NSEntityDescription.entity(forEntityName: "TodoMO",
                                                 in: persistentManager.context)!
        let newTodo = TodoMO(entity: entity, insertInto: persistentManager.context)
        newTodo.uuid = UUID()
        newTodo.title = todo.title
        newTodo.isCompleted = false
        newTodo.isAlarmSet = false
        newTodo.category = todo.category.rawValue
        newTodo.note = todo.note
        newTodo.date = todo.date
        persistentManager.create(newTodo)

        onUpdate?()
    }

    func toggleIsCompleted(for todo: Todo) {
        guard let todoMO = getTodoMO(for: todo) else { return }
        todoMO.isCompleted.toggle()
        persistentManager.update(todoMO)

        onUpdate?()
    }

    func toggleIsAlarmSet(for todo: Todo) {
        guard let todoMO = getTodoMO(for: todo) else { return }

        !todo.isAlarmSet
            ? scheduleNotification(todo: todo)
            : cancelSchedule(for: todo)

        todoMO.isAlarmSet.toggle()
        persistentManager.update(todoMO)

        onUpdate?()
    }

    func scheduleNotification(todo: Todo) {
        let notificationData = LocationNotificationData(
            title: todo.title,
            body: todo.note,
            date: todo.date,
            medaData: LocationNotificationData.MetaData(id: todo.id.uuidString)
        )
        notificationManager.sechedule(data: notificationData)
    }

    func cancelSchedule(for todo: Todo) {
        notificationManager.cancelNotification(id: todo.id.uuidString)
    }
}
