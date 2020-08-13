//
//  MockDataManager.swift
//  TodoApp
//
//  Created by Afees Lawal on 06/08/2020.
//

import Foundation
import Combine

class MockDataManager: DataManager {

    var onUpdate: (() -> Void)?

    let  objectWillChange = PassthroughSubject<(), Never>()

    static let shared = MockDataManager()

    var todos = [Todo]()

    var sampleCheckedTodo: Todo {
        return fetchTodoList().filter { $0.isCompleted }.randomElement() ?? fetchTodoList()[0]
    }

    var sampleTodo: Todo {
        return fetchTodoList().filter { !$0.isCompleted }.randomElement() ?? fetchTodoList()[0]
    }

    init() {
        todos = [
            Todo(id: UUID(), title: "Good day", isCompleted: false, isAlarmSet: false, category: .personal, note: .randomString(), date: Date().add(.minute, value: 15).add(.second, value: 32)),
            Todo(id: UUID(), title: "Fetch water from well", isCompleted: false, isAlarmSet: true, category: .personal, note: .randomString(), date: Date().add(.hour, value: 1).add(.minute, value: 20).add(.second, value: 20)),
            Todo(id: UUID(), title: "Go outside", isCompleted: false, isAlarmSet: true, category: .work, note: .randomString(), date: Date().add(.hour, value: 1).add(.second, value: 15)),
            Todo(id: UUID(), title: "Morning workout", isCompleted: false, isAlarmSet: true, category: .personal, note: .randomString(), date: Date()),
            Todo(id: UUID(), title: "Sign documents", isCompleted: false, category: .work, note: .randomString(), date: Date().add(.day, value: 6).add(.minute, value: 12).add(.second, value: 5)),
            Todo(id: UUID(), title: "Check email", isCompleted: true, isAlarmSet: true, category: .meeting, note: .randomString(), date: Date().add(.day, value: 2).add(.second, value: 34)),
            Todo(id: UUID(), title: "Call boss", isCompleted: false, category: .personal, note: .randomString(), date: Date().add(.day, value: 1).add(.second, value: 27)),
            Todo(id: UUID(), title: "Buy groceries", isCompleted: false, category: .study, note: .randomString(), date: Date().add(.month, value: 2).add(.second, value: 19)),
            Todo(id: UUID(), title: "Finish article", isCompleted: true, category: .shopping, note: .randomString(), date: Date().add(.weekday, value: 2).add(.second, value: 16)),
            Todo(id: UUID(), title: "Blog night", isCompleted: true, category: .shopping, note: .randomString(), date: Date().add(.day, value: 3).add(.second, value: 52)),
            Todo(id: UUID(), title: "Pay bills", isCompleted: true, category: .party, note: .randomString(), date: Date().add(.hour, value: -4).add(.second, value: 34)),
            Todo(id: UUID(), title: "Bring the men", isCompleted: true, category: .shopping, note: .randomString(), date: Date().add(.hour, value: -2).add(.second, value: 29)),
        ]
    }

    func fetchTodoList() -> [Todo] {
        todos
    }

    func add(todo: Todo) {
        todos.append(Todo(title: todo.title, category: todo.category, note: todo.note, date: todo.date))
        onUpdate?()
    }

    func toggleIsCompleted(for todo: Todo) {
        if let index = todos.firstIndex(where: { $0 == todo }) {
            todos[index].isCompleted.toggle()
        }
        onUpdate?()
    }

    func toggleIsAlarmSet(for todo: Todo) {
        if let index = todos.firstIndex(where: { $0 == todo }) {
            todos[index].isAlarmSet.toggle()
        }
        onUpdate?()
    }

    func todosCategory(for category: Todo.Category) -> Category {
        Category(todos: fetchTodoList().filter { $0.category == category }, category: category)
    }
}

extension String {
    static func randomString(length: Int = .random(in: 5...8)) -> String {
      let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
      return String((0..<length).map{ _ in letters.randomElement()! })
    }
}
