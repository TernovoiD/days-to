//
//  LinearBackgroundColor.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 03.03.2023.
//

import SwiftUI

struct LinearBackgroundColor: ViewModifier {
    var backgroundColor: Color
    
    func body(content: Content) -> some View {
        content
            .background(
                LinearGradient(colors: [backgroundColor, backgroundColor.opacity(0.8)], startPoint: .topLeading, endPoint: .bottomTrailing)
            )
    }
}

extension View {
    func linearBackground(backgroundColor: Color) -> some View {
        self.modifier(LinearBackgroundColor(backgroundColor: backgroundColor))
    }
}

