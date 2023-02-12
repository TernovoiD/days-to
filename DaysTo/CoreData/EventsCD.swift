//
//  EventsCD.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 02.02.2023.
//
import CoreData

class EventsCD {
    
    func fetch() -> [EventEntity] {
        let request = NSFetchRequest<EventEntity>(entityName: "EventEntity")
        do {
            let fetchedEvents = try CoreDataManager.shared.viewContext.fetch(request)
            return fetchedEvents
        } catch let error {
            print("Error while fetch Events: \(error)")
            return []
        }
    }
    
    func save() {
        do {
            try CoreDataManager.shared.viewContext.save()
        } catch let error {
            print("Error while saving Events: \(error)")
        }
    }
    
    func add(name: String, info: String, date: Date, isFavorite: Bool, isRepeated: Bool) {
        let newEntity = EventEntity(context: CoreDataManager.shared.viewContext)
        newEntity.uuidString = UUID().uuidString
        newEntity.name = name
        newEntity.information = info
        newEntity.date = date
        newEntity.isFavorite = isFavorite
        newEntity.isRepeated = isRepeated
    }
    
    func edit(_ event: EventEntity, newName: String, newDate: Date, isFavorite: Bool, isRepeated: Bool) {
        event.name = newName
        event.date = newDate
        event.isFavorite = isFavorite
        event.isRepeated = isRepeated
    }
    
    func changeFavoriteStatus(_ event: EventEntity) {
        let currentStatus = event.isFavorite
        let newStatus = !currentStatus
        event.isFavorite = newStatus
    }
    
    func delete(_ event: EventEntity) {
        CoreDataManager.shared.viewContext.delete(event)
    }
}
