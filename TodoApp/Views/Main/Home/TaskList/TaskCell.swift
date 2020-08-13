//
//  TaskCell.swift
//  TodoApp
//
//  Created by Afees Lawal on 06/08/2020.
//

import SwiftUI

struct TaskCell: View {

    let todo: Todo

    var onToggleCompletedTask: (() -> Void)?
    var onToggleSetReminder: (() -> Void)?

    var body: some View {
        GeometryReader { geometry in
            HStack {
                Color.categoryColor(for: todo.category)
                    .frame(width: 4, height: geometry.size.height)


                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(todo.isCompleted ? .green : .gray)
                    .onTapGesture {
                        self.onToggleCompletedTask?()
                    }

                VStack(alignment: .leading, spacing: 8) {
                    Text(todo.title)
                        .foregroundColor(todo.isCompleted ? .gray : .primaryTextColor)
                        .strikethrough(todo.isCompleted)
                        .font(.setFont(size: 16 , weight: .bold))

                    Text(todo.note)
                        .foregroundColor(todo.isCompleted ? .gray : Color.primaryTextColor.opacity(0.7))
                        .strikethrough(todo.isCompleted)
                        .multilineTextAlignment(.leading)
                        .font(.setFont(size: 13))
                }

                Spacer()

                VStack(alignment: .trailing) {
                    Text(todo.time)
                        .foregroundColor(.infoColor)
                        .font(.setFont(size: 11))
                        .padding(EdgeInsets.init(top: 0, leading: 0, bottom: 0, trailing: 8))

                    Image(systemName: "bell.fill")
                        .resizable()
                        .frame(width: 18, height: 20)
                        .cornerRadius(10)
                        .foregroundColor(todo.isAlarmSet ? .lightYellow : .gray)
                        .padding(.trailing, 10)
                        .onTapGesture {
                            self.onToggleSetReminder?()
                        }
                }
            }
        }
        .cornerRadius(5)
        .background(Color.rowColor).cornerRadius(5)
        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 5)
    }
}

struct TaskCell_Previews: PreviewProvider {
    static var previews: some View {
        TaskCell(todo: MockDataManager.shared.sampleTodo)
    }
}
