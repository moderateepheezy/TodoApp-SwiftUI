//
//  CategoriesCell.swift
//  TodoApp
//
//  Created by Afees Lawal on 13/08/2020.
//

import SwiftUI

struct CategoriesCell: View {

    let category: Category

    var body: some View {
        GeometryReader { geometry in
            VStack {
                Spacer()

                Image(category.category.imageName)
                    .frame(width: 65, height: 65)

                Text(category.category.rawValue)
                    .foregroundColor(.primaryTextColor)
                    .font(.setFont(size: 16, weight: .bold))

                Text((Str.Main.Categories.tasksCount(category.tasksCount)))
                    .foregroundColor(Color.primaryTextColor.opacity(0.7))
                    .font(.setFont(size: 14))

                Spacer()
            }.frame(width: geometry.size.width, height: geometry.size.height)
        }
    }
}

struct CategoriesCell_Previews: PreviewProvider {
    static var previews: some View {
        CategoriesCell(category: MockDataManager.shared.todosCategory(for: .personal))
    }
}
