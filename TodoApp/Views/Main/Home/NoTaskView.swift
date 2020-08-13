//
//  NoTaskView.swift
//  TodoApp
//
//  Created by Afees Lawal on 05/08/2020.
//

import SwiftUI

struct NoTaskView: View {
    var body: some View {
        VStack {
            Image("noTask")

            Text(Str.Main.Home.EmptyTask.noTasks)
                .foregroundColor(.primaryTextColor)
                .font(.setFont(size: 22, weight: .medium))
                .padding(.init(top: 70, leading: 0, bottom: 12, trailing: 0))

            Text(Str.Main.Home.EmptyTask.noTasksTodo)
                .foregroundColor(.infoColor)
                .font(.setFont(size: 17))
        }
    }
}

struct NoTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NoTaskView()
    }
}
