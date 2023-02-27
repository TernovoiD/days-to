//
//  SelectedTextField.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 26.02.2023.
//

import SwiftUI

struct SelectedField: ViewModifier {
    var colors: [Color]
    
    func body(content: Content) -> some View {
        content
            .background(
                RoundedRectangle(cornerRadius: 15, style: .continuous)
                    .stroke(lineWidth: 3)
                    .foregroundStyle(
                        .linearGradient(colors: colors, startPoint: .topLeading, endPoint: .bottomTrailing)
                    )
            )
    }
}

extension View {
    func selectedField(colors: [Color]) -> some View {
        self.modifier(SelectedField(colors: colors))
    }
}
