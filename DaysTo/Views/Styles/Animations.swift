//
//  Animations.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 05.02.2023.
//

import SwiftUI

extension Animation {
    static let openPlate = Animation.spring(response: 0.4, dampingFraction: 0.4, blendDuration: 0.4)
    static let closePlate = Animation.spring(response: 0.5, dampingFraction: 0.5, blendDuration: 0.5)
}
