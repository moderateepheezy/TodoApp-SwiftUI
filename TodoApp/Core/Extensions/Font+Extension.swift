//
//  Font+Extension.swift
//  TodoApp
//
//  Created by Afees Lawal on 04/08/2020.
//

import SwiftUI

extension Font {
    static func setFont(size: CGFloat, weight: Font.Weight = .regular) -> Font {
        system(size: size, weight: weight, design: Design.monospaced)
    }
}
