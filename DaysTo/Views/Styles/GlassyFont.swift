//
//  GlassyFont.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 25.02.2023.
//

import SwiftUI

struct GlassyFontModifier: ViewModifier {
    var textColor: Color
    
    func body(content: Content) -> some View {
        content
            .foregroundStyle(.linearGradient(colors: [textColor, textColor.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing))
    }
}

extension View {
    func glassyFont(textColor: Color) -> some View {
        self.modifier(GlassyFontModifier(textColor: textColor))
    }
}
