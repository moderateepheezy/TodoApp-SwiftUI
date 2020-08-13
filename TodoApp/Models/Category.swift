//
//  Category.swift
//  TodoApp
//
//  Created by Afees Lawal on 12/08/2020.
//

import Foundation

struct Category: Hashable {
    let todos: [Todo]
    let category: Todo.Category

    var tasksCount: Int {
        todos.count
    }
}
