//
//  CustomizationModel.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 10.02.2023.
//

import SwiftUI

struct CustomizationModel: Identifiable {
    let id: String
    let name: String
    let color: Color
    let backgroundPicture: String
    
    init(name: String, color: Color, backgroundPicture: String) {
        self.id = UUID().uuidString
        self.name = name
        self.color = color
        self.backgroundPicture = backgroundPicture
    }
}

extension CustomizationModel {
    static let colorSchemes = [
        CustomizationModel(name: "Indigo", color: Color.indigo, backgroundPicture: "Background Purple Waves"),
        CustomizationModel(name: "Ocean", color: Color.blue, backgroundPicture: "Background Blue Waves"),
        CustomizationModel(name: "Orange", color: Color.orange, backgroundPicture: "Background Orange Waves"),
        CustomizationModel(name: "Pink", color: Color.pink, backgroundPicture: "Background Pink Waves"),
        CustomizationModel(name: "Red", color: Color.red, backgroundPicture: "Background Red Waves"),
    ]
}
