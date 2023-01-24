//
//  EventModel.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 22.01.2023.
//

import Foundation

//struct Event: Identifiable {
//    let event: EventEntity
//
//    var id: String {
//        event.id
//    }
//    var name: String {
//        event.name ?? "Unknown"
//    }
//    var description: String {
//        event.description
//    }
//    var dateInfo: DateInformation {
//        return DateInformation(originalDate: event.date ?? Date(),
//                               repeatAnnually: event.repeatAnnual)
//    }
//    var isFavorite: Bool {
//        event.favorite
//    }
//
//    var isValid: Bool {
//        !name.isEmpty
//    }
//
//    init(event: EventEntity) {
//        self.event = event
//    }
//}

//struct DateInformation {
//    let originalDate: Date
//    var repeatAnnually: Bool
//
//    private var isFutureEvent: Bool {
//        originalDate >= Date() ? true : false
//    }
//
//    var isActual: Bool {
//        if isFutureEvent || repeatAnnually { return true } else { return false }
//    }
//
//    var nextCelebrationDate: Date {
//        switch isFutureEvent {
//        case true:
//            return originalDate
//        case false:
//            let calendar: Calendar = Calendar.current
//            let eventDate: Date = calendar.startOfDay(for: originalDate)
//            let today: Date = calendar.startOfDay(for: Date())
//            let originalDateDC = calendar.dateComponents([.day, .month], from: eventDate)
//            return calendar.nextDate(after: today, matching: originalDateDC, matchingPolicy: .nextTimePreservingSmallerComponents) ?? Date()
//        }
//    }
//
//    var daysLeftToEvent: Int {
//        switch isActual {
//        case true:
//                let calendar: Calendar = Calendar.current
//                let today = calendar.startOfDay(for: Date())
//                let calebrationDay = calendar.startOfDay(for: nextCelebrationDate)
//                return calendar.dateComponents([.day], from: today, to: calebrationDay).day ?? 999
//        case false:
//            return 999
//        }
//    }
//
//    enum DateInterval {
//        case annual
//        case none
//    }
//
//    init(originalDate: Date, repeatAnnually: Bool) {
//        self.originalDate = originalDate
//        self.repeatAnnually = repeatAnnually
//    }
//
//    init() {
//        self.init(originalDate: Date(), repeatAnnually: true)
//    }
//}

//extension Event {
//    static let testEvents: [Event] = [
//        Event(name: "Test One", description: "Test Description", dateInfo: DateInformation(), isFavorite: false),
//        Event(name: "Test Two", description: "Test Description", dateInfo: DateInformation(), isFavorite: false),
//        Event(name: "Test Three", description: "Test Description", dateInfo: DateInformation(), isFavorite: true),
//        Event(name: "Test Four", description: "Test Description", dateInfo: DateInformation(), isFavorite: false),
//        Event(name: "Test Five", description: "Test Description", dateInfo: DateInformation(), isFavorite: false),
//        Event(name: "Test Six", description: "Test Description", dateInfo: DateInformation(), isFavorite: false),
//        Event(name: "Test Seven", description: "Test Description", dateInfo: DateInformation(), isFavorite: false)
//    ]
//}
