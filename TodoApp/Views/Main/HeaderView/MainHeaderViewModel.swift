//
//  MainHeaderViewModel.swift
//  TodoApp
//
//  Created by Afees Lawal on 12/08/2020.
//

import Foundation
import Combine

class MainHeaderViewModel: ObservableObject {

    let objectWillChange = PassthroughSubject<Void, Never>()

    @Published var mostRecentTodoWithNotification:  Todo?
    @Published var todayTasksCount: Int = 0

    private var dataManager: DataManager

    init(dataManager:  DataManager) {
        self.dataManager = dataManager
        update()

        self.dataManager.onUpdate = { [weak self] in
            self?.objectWillChange.send()
        }
    }

    func update() {
        mostRecentTodoWithNotification = dataManager.mostRecentTodoWithNotification
        todayTasksCount = dataManager.todaysTaskCount
    }
}
