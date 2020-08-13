//
//  MainTabBar.swift
//  TodoApp
//
//  Created by Afees Lawal on 05/08/2020.
//

import SwiftUI

struct MainTabBar: View {

    let size: CGSize

    @ObservedObject var viewRouter = MainViewRouter()
    
    @Binding var currentRoute: MainViewRouter.Route

    var onNewTaskTapped: (() -> Void)?

    var body: some View {
        HStack {
            Image(self.currentRoute == .home ? "home" : "home_unselected")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(20)
                .frame(width: size.width/3, height: 75)
                .onTapGesture {
                    self.viewRouter.currentRoutes = .home
                    self.currentRoute = .home
                }

            ZStack {
                Circle()
                    .foregroundColor(Color.white)
                    .frame(width: 75, height: 75)
                Image(systemName: "plus.circle.fill")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 75, height: 75)
                    .foregroundColor(.addTaskButtonColor)
            }
            .offset(y: -size.height/10/2)
            .shadow(color: Color.addTaskButtonColor.opacity(0.24), radius: 5, x: 0, y: 7)
            .onTapGesture {
                self.onNewTaskTapped?()
            }

            Image(self.currentRoute == .tasks ? "task" : "task_unselected")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(20)
                .frame(width: size.width/3, height: 75)
                .foregroundColor(self.currentRoute == .tasks ? .black : .gray)
                .onTapGesture {
                    self.viewRouter.currentRoutes = .tasks
                    self.currentRoute = .tasks
                }
        }
        .frame(width: size.width, height: size.height / 10, alignment: .bottom)
        .background(Color.backgroundColor.shadow(radius: 2, x: 0, y: -3).opacity(0.3))
    }
}

struct MainTabBar_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReader { geo in
            MainTabBar(size: geo.size, currentRoute: .constant(.home))
        }
        .preferredColorScheme(.dark)
    }
}
