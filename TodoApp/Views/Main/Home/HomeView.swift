//
//  HomeView.swift
//  TodoApp
//
//  Created by Afees Lawal on 05/08/2020.
//

import SwiftUI

struct HomeView: View {

    @ObservedObject var viewModel: TaskListViewModel

    var body: some View {
        GeometryReader { geometry in
            Group {
                if viewModel.sectionedTodos.isEmpty {
                    NoTaskView()
                        .frame(width: geometry.size.width, height: geometry.size.height)
                } else {
                    TaskListView(viewModel: viewModel)
                }
            }
        }
        .onAppear {
            viewModel.fetchTodos()
        }
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView(viewModel: TaskListViewModel(dataManager: TodoDataManager()))
            .preferredColorScheme(.dark)
    }
}
