//
//  EventModel.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 13.02.2023.
//

import Foundation

struct EventModel: Identifiable, Codable, Equatable {
    var id: String
    var date: Date
    var name: String
    var isRepeated: Bool
    var isFavorite: Bool
    var description: String
    
    init(date: Date, name: String, isRepeated: Bool, isFavorite: Bool, description: String) {
        self.id = UUID().uuidString
        self.date = date
        self.name = name
        self.isRepeated = isRepeated
        self.isFavorite = isFavorite
        self.description = description
    }
    
    var isFutureEvent: Bool {
        return date >= Date() ? true : false
    }
    
    var isActual: Bool {
        return isFutureEvent || isRepeated ? true : false
    }
    
    var anniversaryDate: Date {
        if isFutureEvent {
            return date
        } else {
            let calendar = Calendar.current
            let today: Date = calendar.startOfDay(for: Date())
            let eventDate: Date = calendar.startOfDay(for: date)
            let eventDateDC = calendar.dateComponents([.day, .month], from: eventDate)
            return calendar.nextDate(after: today, matching: eventDateDC, matchingPolicy: .nextTimePreservingSmallerComponents) ?? Date()
        }
    }
    
    var daysTo: Int {
            let calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())
            let dateOfEvent = calendar.startOfDay(for: anniversaryDate)
            guard let daysTo = calendar.dateComponents([.day], from: today, to: dateOfEvent).day else { return 999 }
        if daysTo == 366 {
            return 0
        } else {
            return daysTo
        }
    }
    
    var daysToDescription: String {
        switch daysTo {
        case 1:
            return "day"
        default:
            return "days"
        }
    }
    
    var age: Int {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let dateOfEvent = calendar.startOfDay(for: date)
        guard let age = calendar.dateComponents([.year], from: today, to: dateOfEvent).year else { return 999 }
        return abs(age)
    }
    
    var ageInDays: Int {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let dateOfEvent = calendar.startOfDay(for: date)
        guard let age = calendar.dateComponents([.day], from: today, to: dateOfEvent).day else { return 999 }
        return abs(age)
    }
    
    
}

extension EventModel {
    
    static func == (lhs: EventModel, rhs: EventModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    static let testEvents: [EventModel] = [
        EventModel(date: Date(timeIntervalSince1970: 3600 * 24 * 365 * 29 + 3600 * 24 * 200), name: "Mike's birthday", isRepeated: true, isFavorite: true, description: "Additional Info"),
        EventModel(date: Date(timeIntervalSince1970: 3600 * 24 * 365 * 49 + 3600 * 24 * 50), name: "The day I've met my wife", isRepeated: true, isFavorite: true, description: "Additional Info"),
        EventModel(date: Date(timeIntervalSince1970: 3600 * 24 * 365 * 71 - 3600 * 24 * 13), name: "Cars will be flying", isRepeated: true, isFavorite: false, description: "Additional Info")
    ]
}
