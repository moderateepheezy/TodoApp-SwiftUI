//
//  CategoriesView.swift
//  TodoApp
//
//  Created by Afees Lawal on 12/08/2020.
//

import SwiftUI

struct CategoriesView: View {

    @ObservedObject var viewModel: CategoriesViewModel

    private let gridItemLayout = [GridItem(.flexible()), GridItem(.flexible())]

    var body: some View {
        ScrollView {
            LazyVGrid(columns: gridItemLayout, spacing: 15) {
                ForEach(viewModel.categories, id: \.self) { category in
                    NavigationLink(destination: TaskListView(viewModel: TaskListViewModel(dataManager: TodoDataManager(), category: category.category), title: category.category.rawValue)){
                        VStack {
                            CategoriesCell(category: category)
                                .frame(height: 180)
                                .cornerRadius(5)
                                .background(Color.rowColor).cornerRadius(5)
                                .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
                        }
                        }
                }
            }
            .padding(.all, 20)
        }
        .onReceive(viewModel.objectWillChange) { _ in
            viewModel.fetchCategories()
        }
    }
}

struct CategoriesView_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesView(viewModel: CategoriesViewModel(dataManager: MockDataManager.shared))
            .preferredColorScheme(.dark)
    }
}
