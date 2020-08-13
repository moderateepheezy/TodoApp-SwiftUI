//
//  TaskTitleView.swift
//  TodoApp
//
//  Created by Afees Lawal on 10/08/2020.
//

import SwiftUI

struct TaskTitleView: View {

    @Binding var userInput: String
    @Binding var showErrorMessage: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text(Str.Main.NewTask.taskTitle)
                .multilineTextAlignment(.leading)
                .font(.setFont(size: 13, weight: .medium))
                .foregroundColor(Color.gray.opacity(0.5))
                .padding(.top, 30)
                .padding(.leading, 20)

            TextField("", text: $userInput)
                .font(.setFont(size: 17, weight: .regular))
                .foregroundColor(Color.white.opacity(0.7))
                .frame(height: 60)
                .padding(.leading, 10)
                .background(Color.black.opacity(0.7).cornerRadius(5))
                .padding(.leading)
                .padding(.trailing)

            if showErrorMessage {
                Text(Str.Main.NewTask.taskTitleEmpty)
                    .multilineTextAlignment(.leading)
                    .font(.setFont(size: 12, weight: .regular))
                    .foregroundColor(Color.red)
                    .padding(.leading, 20)
            }
        }
    }
}

struct TaskTitleView_Previews: PreviewProvider {
    static var previews: some View {
        TaskTitleView(userInput: .constant(""), showErrorMessage: .constant(true))
    }
}
