//
//  TodoMO+Extension.swift
//  TodoApp
//
//  Created by Afees Lawal on 05/08/2020.
//

import Foundation

extension TodoMO {
    func todoModel() -> Todo {
        Todo(
            id: uuid ?? UUID(),
            title: title ?? "Unknown",
            isCompleted: isCompleted,
            isAlarmSet: isAlarmSet,
            category: Todo.Category.init(rawValue: category ?? Todo.Category.personal.rawValue) ?? .personal,
            note: note ?? "",
            date: date ?? Date()
        )
    }
}
