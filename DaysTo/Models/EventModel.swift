//
//  EventModel.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 22.01.2023.
//

import Foundation

struct Event: Hashable, Identifiable {
    let entity: EventEntity
    
    var id: UUID {
        entity.eventID ?? UUID()
    }
    
    var name: String {
        entity.nameOfEvent ?? "Unknown"
    }
    
    var information: String {
        entity.information ?? "Event information..."
    }
    
    var originalDate: Date {
        entity.originalDate ?? Date()
    }
    
    var isFavorite: Bool {
        entity.isFavorite
    }
    
    var isRepeated: Bool {
        entity.isRepeated
    }
    
    var isFutureEvent: Bool {
        originalDate >= Date() ? true : false
    }
    
    var isActual: Bool {
        if isFutureEvent || isRepeated { return true } else { return false }
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
        switch isActual {
        case true:
            let calendar: Calendar = Calendar.current
            let today = calendar.startOfDay(for: Date())
            let calebrationDay = calendar.startOfDay(for: nextCelebrationDate)
            return calendar.dateComponents([.day], from: today, to: calebrationDay).day ?? 999
        case false:
            return 999
        }
    }
}
