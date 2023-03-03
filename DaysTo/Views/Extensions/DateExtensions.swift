//
//  DateExtensions.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 28.02.2023.
//

import SwiftUI

extension Date {
    func simpleDate(formatStyle: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = formatStyle
        return dateFormatter.string(from: self)
    }
}
