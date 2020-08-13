//
//  CategoriesViewModel.swift
//  TodoApp
//
//  Created by Afees Lawal on 12/08/2020.
//

import Foundation
import Combine

final class CategoriesViewModel: ObservableObject {

    let objectWillChange = PassthroughSubject<Void, Never>()

    @Published var categories: [Category] = []

    var dataManager: DataManager

    init(dataManager: DataManager) {
        self.dataManager = dataManager
        fetchCategories()

        self.dataManager.onUpdate = { [weak self] in
            self?.objectWillChange.send()
        }
    }

    func fetchCategories() {
        categories.removeAll()
        self.categories = dataManager.fetchTodoCategories()
    }
}
