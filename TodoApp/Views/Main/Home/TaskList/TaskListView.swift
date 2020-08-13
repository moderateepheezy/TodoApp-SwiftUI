//
//  TaskListView.swift
//  TodoApp
//
//  Created by Afees Lawal on 06/08/2020.
//

import SwiftUI

struct TaskListView: View {

    @ObservedObject var viewModel: TaskListViewModel
    var title: String? = nil

    private let generator = UINotificationFeedbackGenerator()

    var body: some View {
        ScrollView {
            ForEach(viewModel.dateKeys) { section in
                VStack {
                    HStack {
                        Text(section.day)
                            .foregroundColor(.sectionTitleColor)
                            .font(.setFont(size: 14, weight: .medium))
                        Spacer()
                    }
                    ForEach(viewModel.todos(for: section), id: \.id) { todo in
                        TaskCell(todo: todo, onToggleCompletedTask: {
                            self.viewModel.toggleIsCompleted(for: todo)
                            generator.notificationOccurred(todo.isCompleted ? .error : .warning)
                        }, onToggleSetReminder: {
                            self.viewModel.toggleAlarm(for: todo)
                            generator.notificationOccurred(todo.date.isPast ? .error : .warning)
                        })
                        .frame(height: 80)
                    }
                }
                .padding(.top, 15)
                .background(Color.backgroundColor)
            }
        }
        .navigationTitle(Text(title ?? ""))
        .background(Color.backgroundColor)
        .padding(.leading, 8)
        .padding(.trailing, 8)
        .onAppear {
            self.viewModel.fetchTodos()
        }
        .onReceive(viewModel.objectWillChange) { _ in
            self.viewModel.fetchTodos()
        }
    }
}

struct TodoListView_Previews: PreviewProvider {
    static var previews: some View {
        TaskListView(viewModel: TaskListViewModel(dataManager: TodoDataManager()))
    }
}
