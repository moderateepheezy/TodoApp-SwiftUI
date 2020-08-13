//
//  TaskDateView.swift
//  TodoApp
//
//  Created by Afees Lawal on 10/08/2020.
//

import SwiftUI

struct TaskDateView: View {

    @Binding var selectedDate: Date
    @Binding var showErrorMessage: Bool

    var body: some View {
        VStack(alignment: .leading) {
            Text(Str.Main.NewTask.timeDate)
                .multilineTextAlignment(.leading)
                .font(.setFont(size: 13, weight: .medium))
                .foregroundColor(Color.gray.opacity(0.5))
                .padding(.top, 20)
                .padding(.leading, 20)

            DatePicker("", selection: $selectedDate, displayedComponents: [.date, .hourAndMinute])
                .foregroundColor(Color.white.opacity(0.7))
                .padding(.trailing, 30)
                .frame(width: 120, height: 40)
                .padding(.leading, 80)

            if showErrorMessage {
                Text(Str.Main.NewTask.lateDateSelected)
                    .multilineTextAlignment(.leading)
                    .font(.setFont(size: 12, weight: .regular))
                    .foregroundColor(Color.red)
                    .padding(.leading, 20)
            }
        }
    }
}

struct TaskDateView_Previews: PreviewProvider {
    static var previews: some View {
        TaskDateView(selectedDate: .constant(Date()), showErrorMessage: .constant(true))
    }
}
