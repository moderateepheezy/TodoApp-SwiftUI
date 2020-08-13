//
//  MainView.swift
//  TodoApp
//
//  Created by Afees Lawal on 04/08/2020.
//

import SwiftUI

struct MainView: View {

    @State var currentRoute: MainViewRouter.Route = .home
    @State var showNewTaskView = false

    @StateObject var dataManager = TodoDataManager()

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                VStack {
                    MainHeaderView(viewModel: MainHeaderViewModel(dataManager: dataManager))

                    Group {
                        switch currentRoute {
                        case .home:
                            HomeView(viewModel: TaskListViewModel(dataManager: dataManager))
                        default:
                            CategoriesView(viewModel: CategoriesViewModel(dataManager: dataManager))
                        }
                    }

                    MainTabBar(size: geometry.size, currentRoute: $currentRoute) {
                        self.showNewTaskView.toggle()
                    }
                }.padding(.bottom, 20)
            }
            .background(Color.backgroundColor)
            .edgesIgnoringSafeArea(.all)
            .sheet(isPresented: $showNewTaskView) {
                NewTaskView(viewModel: NewTaskViewModel(dataManager: dataManager))
            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .preferredColorScheme(.dark)
    }
}
