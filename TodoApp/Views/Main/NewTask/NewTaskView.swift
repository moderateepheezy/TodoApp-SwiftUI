//
//  NewTaskView.swift
//  TodoApp
//
//  Created by Afees Lawal on 09/08/2020.
//

import SwiftUI

struct NewTaskView: View {

    @Environment(\.presentationMode) private var presentationMode

    @ObservedObject var viewModel: NewTaskViewModel
    @ObservedObject private var textFieldManager = TextFieldManager(characterLimit: 50)
    @ObservedObject private var noteTextFieldManager = TextFieldManager(characterLimit: 80)

    @State private var selectedDate = Date()
    @State private var selectedCategoryColor: Color = .categoryColor(for: .personal)

    @State private var showTaskTitleErrorMessage: Bool = false
    @State private var showTaskNoteErrorMessage: Bool = false
    @State private var showDateSelectedErrorMessage: Bool = false
    @State private var category: Todo.Category = .personal

    var canCreateTask: Bool {
        return !(showTaskTitleErrorMessage || showTaskNoteErrorMessage || showDateSelectedErrorMessage)
    }

    var body: some View {
        GeometryReader { geometry in
            VStack {

                RoundedRectangle(cornerRadius: 5, style: .circular)
                    .foregroundColor(.gray)
                    .frame(width: 70, height: 6)

                VStack(alignment: .leading) {

                    TaskTitleView(userInput: $textFieldManager.userInput, showErrorMessage: $showTaskTitleErrorMessage)

                    TaskNoteView(userInput: $noteTextFieldManager.userInput, showErrorMessage: $showTaskNoteErrorMessage)

                    TaskCategoryView(selectedCategoryColor: $selectedCategoryColor) { category in
                        self.category = category
                    }

                    TaskDateView(selectedDate: $selectedDate, showErrorMessage: $showDateSelectedErrorMessage)
                }

                Spacer()

                Button(Str.Main.NewTask.createTask) {
                    self.createTask()
                }
                .padding()
                .frame(width: geometry.size.width - 40, height: 50)
                .foregroundColor(.white)
                .background(Color.addTaskButtonColor.cornerRadius(5).opacity(0.9))

                Spacer()
            }
            .padding(.top)
        }
        .background(Color.backgroundColor)
        .onTapGesture {
            UIApplication.shared
                .sendAction(#selector(UIResponder.resignFirstResponder), to:nil, from:nil, for:nil)
        }
        .onAppear {
            UITextView.appearance().backgroundColor = .clear
            UITableView.appearance().backgroundColor = .clear
        }
    }

    func createTask() {
        let title = textFieldManager.userInput
        let note = noteTextFieldManager.userInput

        showTaskTitleErrorMessage = title.isEmpty
        showTaskNoteErrorMessage = note.isEmpty
        showDateSelectedErrorMessage = selectedDate.isPast

        if canCreateTask {
            let todo = Todo(title: title, category: category, note: note, date: selectedDate)
            viewModel.addNewTask(todo: todo)
            presentationMode.wrappedValue.dismiss()
        }
    }
}

struct NewTaskView_Previews: PreviewProvider {
    static var previews: some View {
        NewTaskView(viewModel: NewTaskViewModel(dataManager: MockDataManager.shared))
            .preferredColorScheme(.dark)
    }
}
