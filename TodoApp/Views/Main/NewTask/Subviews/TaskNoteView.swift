//
//  TaskNoteView.swift
//  TodoApp
//
//  Created by Afees Lawal on 10/08/2020.
//

import SwiftUI

struct TaskNoteView: View {

    @Binding var userInput: String
    @Binding var showErrorMessage: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text(Str.Main.NewTask.noteDescription)
                .multilineTextAlignment(.leading)
                .font(.setFont(size: 13, weight: .medium))
                .foregroundColor(Color.gray.opacity(0.5))
                .padding(.top, 20)
                .padding(.leading, 20)

            TextEditor(text: $userInput)
                .font(.setFont(size: 17))
                .padding(.leading, 10)
                .background(Color.black.opacity(0.7).cornerRadius(5))
                .frame(height: 80)
                .padding()
                .foregroundColor(Color.white.opacity(0.7))
                .frame(height: 80)

            if showErrorMessage {
                Text(Str.Main.NewTask.taskNoteEmpty)
                    .multilineTextAlignment(.leading)
                    .font(.setFont(size: 12, weight: .regular))
                    .foregroundColor(Color.red)
                    .padding(.leading, 20)
            }
        }
    }
}

struct TaskNoteView_Previews: PreviewProvider {
    static var previews: some View {
        TaskNoteView(userInput: .constant(""), showErrorMessage: .constant(true))
    }
}
