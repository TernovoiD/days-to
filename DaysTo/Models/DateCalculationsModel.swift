//
//  DateCalculationsModel.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 29.01.2023.
//

import Foundation

struct DateCalculationsModel {
    let calendar: Calendar = Calendar.current
    
    func calculateAnniversary(for originalDate: Date) -> Date {
        let today: Date = calendar.startOfDay(for: Date())
        let eventDate: Date = calendar.startOfDay(for: originalDate)
        let eventDateDC = calendar.dateComponents([.day, .month], from: eventDate)
        return calendar.nextDate(after: today, matching: eventDateDC, matchingPolicy: .nextTimePreservingSmallerComponents) ?? Date()
    }
    
    func calculateDaysLeft(to eventDate: Date) -> Int {
        let today = calendar.startOfDay(for: Date())
        let dateOfEvent = calendar.startOfDay(for: eventDate)
        guard let daysTo = calendar.dateComponents([.day], from: today, to: dateOfEvent).day else { return 999 }
        return daysTo
    }
    
    func getStartOfNextMonthDate() -> Date {
        let today = Date()
        let todayDC = calendar.dateComponents([.day, .month, .year], from: today)
        let currentMonth = todayDC.month ?? 1
        let currentYear = todayDC.year ?? 1998
        let startOfNextMonthDC = DateComponents(
            year: currentMonth == 12 ? currentYear + 1 : currentYear,
            month: currentMonth == 12 ? 1 : currentMonth + 1,
            day: 1
        )
        return calendar.date(from: startOfNextMonthDC) ?? Date()
    }
    
    func getStartOnNextYearDate() -> Date {
        let today = Date()
        let todayDC = calendar.dateComponents([.year], from: today)
        let currentYear = todayDC.year ?? 1998
        let startOfNextYearDC = DateComponents(
            year: currentYear + 1,
            month: 1,
            day: 1
        )
        return calendar.date(from: startOfNextYearDC) ?? Date()
    }
    
    func getDaysInCurrentMonth() -> Int {
        let today = Date()
        let range = calendar.range(of: .day, in: .month, for: today)
        let numDays = range?.count ?? 999
        return numDays
    }
    
    func getDaysInCurrentYear() -> Int {
        let today = Date()
        let range = calendar.range(of: .day, in: .year, for: today)
        let numDays = range?.count ?? 999
        return numDays
    }
    
    func getDaysLeftCurrentMonth() -> Int {
        let numDays = calculateDaysLeft(to: getStartOfNextMonthDate())
        return numDays
    }
    
    func getDaysLeftCurrentYear() -> Int {
        let numDays = calculateDaysLeft(to: getStartOnNextYearDate())
        return numDays
    }
    
}
