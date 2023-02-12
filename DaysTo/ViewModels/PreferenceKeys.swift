//
//  PreferenceKeys.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 05.02.2023.
//
import SwiftUI

struct ScrollPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = 0
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {
        value = nextValue()
    }
}
