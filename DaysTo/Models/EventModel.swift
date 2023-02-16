//
//  EventModel.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 13.02.2023.
//

import Foundation

struct EventModel: Identifiable, Codable, Equatable {
    let id: String
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
            return daysTo
    }
    
    
}

extension EventModel {
    
    static func == (lhs: EventModel, rhs: EventModel) -> Bool {
        return lhs.id == rhs.id
    }
    
    
    static let testEvents: [EventModel] = [
        EventModel(date: Date(), name: "First Event", isRepeated: true, isFavorite: false, description: "Additional Info"),
        EventModel(date: Date(), name: "Second Event", isRepeated: true, isFavorite: false, description: "Additional Info"),
        EventModel(date: Date(), name: "Third Event", isRepeated: true, isFavorite: false, description: "Additional Info"),
        EventModel(date: Date(), name: "Fourth Event", isRepeated: true, isFavorite: false, description: "Additional Info")
    ]
}
