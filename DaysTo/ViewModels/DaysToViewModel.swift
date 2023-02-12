//
//  DaysToViewModel.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 02.02.2023.
//

import Foundation
import UserNotifications

class DaysToViewModel: ObservableObject {
    
    
    
    // MARK: Navigation controller
    
    @Published var selectedEvent: EventEntity?
    @Published var eventToEdit: EventEntity?
    @Published var showEditEventView: Bool = false
    @Published var showAddEventView: Bool = false
    @Published var showSettingsView: Bool = false
    
    
    
    // MARK: Data
    
    @Published var sortedEvents: [EventEntity] = []
    @Published var thisMonthEvents: [EventEntity] = []
    @Published var thisYearEvents: [EventEntity] = []
    @Published var tags: [TagEntity] = []
    private let dateCalculations = DateCalculationsModel()
    private let eventsCD = EventsCD()
    private let tagsCD = TagsCD()
        
    init() {
        fetchEvents()
        fetchTags()
    }
    
    func saveData() {
        eventsCD.save()
        fetchEvents()
        fetchTags()
    }
    
    
    
    // MARK: Events Controller
    
    func fetchEvents() {
        let allEvents = eventsCD.fetch()
            .filter({ checkRelevance(ofEvent: $0) })
        sortedEvents = allEvents
            .sorted(by: { getDaysLeft(toEvent: $0) < getDaysLeft(toEvent: $1) })
        thisMonthEvents = allEvents
            .sorted(by: { getDaysLeft(toEvent: $0) < getDaysLeft(toEvent: $1) })
            .filter({ getDaysLeft(toEvent: $0) <= daysLeftInCurrentMonth() })
        thisYearEvents = allEvents
            .filter({ getDaysLeft(toEvent: $0) <= daysLeftInCurrentYear() })
    }
    
    func addEvent(withName name: String, andInfo: String, andDate date: Date, isFavorite: Bool, isRepeated: Bool) {
        eventsCD.add(name: name, info: andInfo, date: date, isFavorite: isFavorite, isRepeated: isRepeated)
        saveData()
    }
    
    func editEvent(_ event: EventEntity, newName: String, newDate: Date, isFavorite: Bool, isRepeated: Bool) {
        eventsCD.edit(event, newName: newName, newDate: newDate, isFavorite: isFavorite, isRepeated: isRepeated)
        saveData()
    }
    
    func changeEventFavoriteStatus(_ event: EventEntity) {
        eventsCD.changeFavoriteStatus(event)
        saveData()
    }
    
    func deleteEvent(_ event: EventEntity) {
        eventsCD.delete(event)
        saveData()
    }
    
    private func checkRelevance(ofEvent event: EventEntity) -> Bool {
        guard let dateOfEvent = event.date else { return false }
        return dateOfEvent >= Date() || event.isRepeated ? true : false
    }
    
    func getDaysLeft(toEvent event: EventEntity) -> Int {
        guard let dateOfEvent = event.date else { return 000}
        
        if dateOfEvent > Date() {
            return dateCalculations.calculateDaysLeft(to: dateOfEvent)
        } else {
            let anniversary = getAnniveryDate(forEvent: event)
            return dateCalculations.calculateDaysLeft(to: anniversary)
        }
    }
    
    func getAnniveryDate(forEvent event: EventEntity) -> Date {
        guard let dateOfEvent = event.date else { return Date() }
        return dateCalculations.calculateAnniversary(for: dateOfEvent)
    }
    
    
    
    //MARK: Events filter
    
    @Published var textToSearch: String = ""
    @Published var showFavoriteOnly: Bool = false
    @Published var sevenDays: Bool = false
    
    func eventsfilterdBySearch(events: [EventEntity]) -> [EventEntity] {
        var eventsToFilter: [EventEntity] = events
        
        if showFavoriteOnly {
            eventsToFilter = eventsToFilter.filter({ $0.isFavorite })
        }
        if sevenDays {
            eventsToFilter = eventsToFilter.filter({ getDaysLeft(toEvent: $0) <= 7 })
        }
        if !textToSearch.isEmpty {
            let text: String = textToSearch.lowercased()
            eventsToFilter = eventsToFilter.filter({ $0.name?.lowercased().contains(text) ?? false })
        }
        return eventsToFilter
    }
    
    
    
    // MARK: DateCalculations Controller
    
    func daysInCurrentMonth() -> Int {
        return dateCalculations.getDaysInCurrentMonth()
    }
    func daysLeftInCurrentMonth() -> Int {
        return dateCalculations.getDaysLeftCurrentMonth()
    }
    func daysInCurrentYear() -> Int {
        return dateCalculations.getDaysInCurrentYear()
    }
    func daysLeftInCurrentYear() -> Int {
        return dateCalculations.getDaysLeftCurrentYear()
    }
    
    func startOfNextMonthDate() -> Date {
        return dateCalculations.getStartOfNextMonthDate()
    }
    
    func startOfNextYearDate() -> Date {
        return dateCalculations.getStartOnNextYearDate()
    }
    
    
    
    // MARK: Tags Controller
    
    func fetchTags() {
        let allTags = tagsCD.fetch()
        tags = allTags
    }
    
    func addTag(withName name: String, andColor color: String) {
        tagsCD.add(name: name, color: color)
        saveData()
    }
    
    func deleteTag(_ tag: TagEntity) {
        tagsCD.delete(tag)
        saveData()
    }
}
