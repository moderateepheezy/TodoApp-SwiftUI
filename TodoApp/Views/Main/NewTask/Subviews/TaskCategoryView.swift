//
//  TaskCategoryView.swift
//  TodoApp
//
//  Created by Afees Lawal on 10/08/2020.
//

import SwiftUI

struct TaskCategoryView: View {

    @Binding var selectedCategoryColor: Color
    var onCategorySelected: ((Todo.Category) -> Void)?

    var body: some View {
        VStack(alignment: .leading) {
            Text(Str.Common.category)
                .multilineTextAlignment(.leading)
                .font(.setFont(size: 13, weight: .medium))
                .foregroundColor(Color.gray.opacity(0.5))
                .padding(.top, 20)
                .padding(.leading, 20)

            TextWrappedLayout(items: Todo.Category.allCases.map { $0.rawValue }, normalColor: Color.white.opacity(0.1), selectedColor: $selectedCategoryColor, onItemSelected: { item in
                    let category = Todo.Category.init(rawValue: item) ?? .personal
                    selectedCategoryColor = .categoryColor(for: category)
                    self.onCategorySelected?(category)
                })
                .padding(.leading, 20)
                .padding(.trailing, 30)
                .frame(height: 80)
        }
    }
}

struct TaskCategoryView_Previews: PreviewProvider {
    static var previews: some View {
        TaskCategoryView(selectedCategoryColor: .constant(.blue))
    }
}
