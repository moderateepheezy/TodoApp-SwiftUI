//
//  TaskListViewModel.swift
//  TodoApp
//
//  Created by Afees Lawal on 13/08/2020.
//

import Foundation
import SwiftUI
import Combine

protocol TaskListViewModelProtocol {
    var dateKeys: [Date] { get }
    var sectionedTodos: [Date: [Todo]] { get }
    func fetchTodos()
    func todos(for key: Date) -> [Todo]
    func toggleIsCompleted(for todo: Todo)
    func toggleAlarm(for todo: Todo)
}

final class TaskListViewModel: ObservableObject, TaskListViewModelProtocol {

    @Published var sectionedTodos:  [Date: [Todo]] = [:]

    let objectWillChange = PassthroughSubject<Void, Never>()

    var dateKeys: [Date] {
        return sectionedTodos
            .map { $0.key }.sorted()
    }

    var dataManager: DataManager
    var category: Todo.Category?

    init(dataManager: DataManager, category: Todo.Category? = nil) {
        self.dataManager = dataManager
        self.category = category
        fetchTodos()

        self.dataManager.onUpdate = { [weak self] in
            self?.objectWillChange.send()
        }
    }

    func fetchTodos() {
        let todos = dataManager.fetchTodoList()
        if let category = category {
            sectionedTodos = todos
                .filter { category == $0.category }
                .groupedBy(dateComponents: [.year, .month, .day])
        } else {
            sectionedTodos = todos
                .filter { $0.date.isTodayOrLater }
                .groupedBy(dateComponents: [.year, .month, .day])
        }
    }

    func todos(for key: Date) -> [Todo] {
        return sectionedTodos[key]?.sorted() ?? []
    }

    func toggleIsCompleted(for todo: Todo) {
        dataManager.toggleIsCompleted(for: todo)
        fetchTodos()
    }

    func toggleAlarm(for todo: Todo) {
        guard !todo.date.isPast else { return }
        dataManager.toggleIsAlarmSet(for: todo)
        fetchTodos()
    }
}

