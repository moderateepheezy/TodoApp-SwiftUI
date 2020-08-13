//
//  TodoGradient.swift
//  TodoApp
//
//  Created by Afees Lawal on 04/08/2020.
//

import SwiftUI
//todoHeaderGradientSecondColor
struct TodoGradient: View {

    var colors: [Color] = [Color.todoGradientFirstColor, Color.todoGradientSecondColor]

    var body: some View {
        LinearGradient(gradient: Gradient(colors: colors), startPoint: /*@START_MENU_TOKEN@*/.leading/*@END_MENU_TOKEN@*/, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/)
    }
}

struct TodoGradient_Previews: PreviewProvider {
    static var previews: some View {
        TodoGradient()
    }
}
