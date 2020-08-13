//
//  TextWrappedLayout.swift
//  TodoApp
//
//  Created by Afees Lawal on 09/08/2020.
//

import SwiftUI

struct TextWrappedLayout: View {

    @State var items: [String]
    @State private var selected: String = ""

    var normalColor: Color = Color.black
    @Binding var selectedColor: Color
    var onItemSelected: ((String) -> Void)?

    var body: some View {
        GeometryReader { geometry in
            self.generateContent(in: geometry)
        }.onAppear {
            self.selected = items[0]
        }
    }

    private func generateContent(in g: GeometryProxy) -> some View {
        var width = CGFloat.zero
        var height = CGFloat.zero

        return ZStack(alignment: .topLeading) {
            ForEach(self.items, id: \.self) { item in
                self.item(for: item)
                    .padding([.horizontal, .vertical], 4)
                    .alignmentGuide(.leading, computeValue: { d in
                        if (abs(width - d.width) > g.size.width)
                        {
                            width = 0
                            height -= d.height
                        }
                        let result = width
                        if item == self.items.last! {
                            width = 0 //last item
                        } else {
                            width -= d.width
                        }
                        return result
                    })
                    .alignmentGuide(.top, computeValue: {d in
                        let result = height
                        if item == self.items.last! {
                            height = 0 // last item
                        }
                        return result
                    })
                    .onTapGesture {
                        self.selected = item
                        self.onItemSelected?(item)
                    }
            }
        }
    }

    func item(for text: String) -> some View {
        Text(text)
            .padding(.all, 5)
            .font(.body)
            .background(selected == text ? selectedColor : normalColor)
            .foregroundColor(Color.white)
            .cornerRadius(5)
    }
}

struct TextWrappedLayout_Previews: PreviewProvider {
    static var previews: some View {
        TextWrappedLayout(items: ["Ninetendo", "XBox", "PlayStation", "PlayStation 2", "PlayStation 3", "PlayStation 4"], selectedColor: .constant(.blue))
    }
}
