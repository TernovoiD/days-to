//
//  EventModel.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 22.01.2023.
//

import Foundation

struct Event: Identifiable {
    let id = UUID().uuidString
    var name: String
    var description: String
    var dateInfo: DateInformation
    var status: EventStatus
    
    var isValid: Bool {
        !name.isEmpty
    }
    
    init(name: String, description: String, dateInfo: DateInformation, status: EventStatus) {
        self.name = name
        self.description = description
        self.dateInfo = dateInfo
        self.status = status
    }
    
    init() {
        self.init(name: "Name", description: "Description", dateInfo: DateInformation(), status: .normal)
    }
    
    enum EventStatus {
        case normal
        case favorite
        case nonActual
    }
}

struct DateInformation {
    var originalDate: Date
    var repeatingInterval: DateInterval
    
    private var isFutureEvent: Bool {
        originalDate >= Date() ? true : false
    }
    
    var nextCelebrationDate: Date {
        switch isFutureEvent {
        case true:
            return originalDate
        case false:
            let calendar: Calendar = Calendar.current
            let eventDate: Date = calendar.startOfDay(for: originalDate)
            let today: Date = calendar.startOfDay(for: Date())
            let originalDateDC = calendar.dateComponents([.day, .month], from: eventDate)
            return calendar.nextDate(after: today, matching: originalDateDC, matchingPolicy: .nextTimePreservingSmallerComponents) ?? Date()
        }
    }
    
    var daysLeftToEvent: Int {
        let calendar: Calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let calebrationDay = calendar.startOfDay(for: nextCelebrationDate)
        return calendar.dateComponents([.day], from: today, to: calebrationDay).day ?? 999
    }
    
    enum DateInterval {
        case annual
        case none
    }
    
    init(originalDate: Date, repeatingInterval: DateInterval) {
        self.originalDate = originalDate
        self.repeatingInterval = repeatingInterval
    }
    
    init() {
        self.init(originalDate: Date(), repeatingInterval: .annual)
    }
}

extension Event {
    static let testEvents: [Event] = [
        Event(name: "Test One", description: "Test Description", dateInfo: DateInformation(), status: .normal),
        Event(name: "Test Two", description: "Test Description", dateInfo: DateInformation(), status: .normal),
        Event(name: "Test Three", description: "Test Description", dateInfo: DateInformation(), status: .normal),
        Event(name: "Test Four", description: "Test Description", dateInfo: DateInformation(), status: .normal),
        Event(name: "Test Five", description: "Test Description", dateInfo: DateInformation(), status: .favorite),
        Event(name: "Test Six", description: "Test Description", dateInfo: DateInformation(), status: .nonActual),
        Event(name: "Test Seven", description: "Test Description", dateInfo: DateInformation(), status: .normal)
    ]
}
