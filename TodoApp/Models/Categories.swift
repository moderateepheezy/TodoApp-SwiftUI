//
//  Categories.swift
//  TodoApp
//
//  Created by Afees Lawal on 12/08/2020.
//

import Foundation

struct Category {
    let todos: [Todo]
    let category: Todo.Category

    var todoCount: Int {
        todos.count
    }
}
