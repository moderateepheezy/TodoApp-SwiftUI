//
//  DataManager.swift
//  TodoApp
//
//  Created by Afees Lawal on 05/08/2020.
//

import Foundation

protocol DataManager {
    var mostRecentTodoWithNotification: Todo? { get }
    var todaysTaskCount: Int { get }
    var onUpdate: (() -> Void)? { get set }
    func fetchTodoList() -> [Todo]
    func add(todo: Todo)
    func toggleIsCompleted(for todo: Todo)
    func toggleIsAlarmSet(for todo: Todo)
    func fetchTodoCategories() -> [Category]
}

extension DataManager {
    func fetchTodoCategories() -> [Category] {
        var categories: [Category] = []
        let todos = fetchTodoList()
        for category in Todo.Category.allCases {
            categories.append(Category(todos: todos.filter { $0.category == category }, category: category))
        }
        return categories
    }
}

extension DataManager {
    var mostRecentTodoWithNotification: Todo? {
        fetchTodoList()
            .sorted()
            .first(where: { $0.isAlarmSet && $0.date.isToday })
    }

    var todaysTaskCount: Int {
        fetchTodoList().filter { $0.date.isToday }.count
    }
}
