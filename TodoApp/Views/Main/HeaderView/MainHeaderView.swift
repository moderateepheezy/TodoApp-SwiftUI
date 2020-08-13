//
//  MainHeaderView.swift
//  TodoApp
//
//  Created by Afees Lawal on 05/08/2020.
//

import SwiftUI

struct MainHeaderView: View {

    @ObservedObject var viewModel: MainHeaderViewModel

    var body: some View {
        ZStack {
            TodoGradient(colors: [Color.todoHeaderGradientSecondColor, Color.todoHeaderGradientSecondColor])

            VStack {

                Spacer()

                HStack {
                    VStack(alignment: .leading) {
                        Text("Hello Brenda!")
                            .foregroundColor(.white)
                            .font(.setFont(size: 18, weight: .medium))
                        Text(Str.Main.Home.Header.headerWithTaskCount(taskCount: viewModel.todayTasksCount))
                            .foregroundColor(.white)
                            .font(.setFont(size: 14, weight: .regular))
                    }
                    .padding(.leading)

                    Spacer()

                    Image("photo")
                        .frame(width: 40, height: 40)
                        .padding(.trailing)
                }
                .padding(.all, 10)

                if viewModel.mostRecentTodoWithNotification != nil {
                    HStack {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Today's Reminder")
                                .foregroundColor(.white)
                                .font(.setFont(size: 20, weight: .bold))

                            Text(viewModel.mostRecentTodoWithNotification?.title ?? "")
                                .foregroundColor(.white)
                                .font(.setFont(size: 15))

                            Text(viewModel.mostRecentTodoWithNotification?.time ?? "")
                                .foregroundColor(.white)
                                .font(.setFont(size: 12))
                        }
                        .frame(alignment: .leading)
                        .padding(.all)

                        Spacer()

                        Image("bigBell")
                            .frame(alignment: .trailing)
                            .padding(.all)
                    }
                    .background(Color.reminderViewBackgroundColor)
                    .padding(.leading)
                    .padding(.trailing)
                    .frame(height: 120)
                }
            }
        }
        .frame(height: viewModel.mostRecentTodoWithNotification != nil ? 230 : 120)
        .onAppear {
            viewModel.update()
        }
        .onReceive(viewModel.objectWillChange) { _ in
            self.viewModel.update()
        }
    }
}

struct MainHeaderView_Previews: PreviewProvider {
    static var previews: some View {
        MainHeaderView(viewModel: MainHeaderViewModel(dataManager: MockDataManager.shared))
    }
}
