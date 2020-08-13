//
//  TodoAppApp.swift
//  TodoApp
//
//  Created by Afees Lawal on 04/08/2020.
//

import SwiftUI

@main
struct TodoAppApp: App {

    @State private var firsTimeLogin: Bool = UserDefaults.standard.bool(forKey: "firstTimeLogin")

    var body: some Scene {
        WindowGroup {

            if self.firsTimeLogin {
                MainView()
            }
            else {
                AnyView(OnboardingView(getStartedTapped: $firsTimeLogin))

            }
        }
    }
}
