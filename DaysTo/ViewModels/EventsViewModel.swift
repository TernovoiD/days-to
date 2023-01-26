//
//  EventsViewModel.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 22.01.2023.
//

import Foundation
import CoreData

class EventsViewModel: ObservableObject {
    
    @Published var events: [Event] = []
    let container: NSPersistentContainer
    
    static let shared = EventsViewModel()
    
    var viewContext: NSManagedObjectContext {
        container.viewContext
    }
    
    init() {
        container = NSPersistentContainer(name: "DataContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error while loading DataContainer: \(error)")
            }
        }
        fetchEvents()
    }
    
    func fetchEvents() {
        let request = NSFetchRequest<EventEntity>(entityName: "EventEntity")
        do {
            let allEvents = try viewContext.fetch(request).map(Event.init)
            events = allEvents
                .sorted(by: { $0.daysLeftToEvent < $1.daysLeftToEvent })
                .filter({ $0.isActual })
        } catch let error {
            print("Error while fetch Events: \(error)")
        }
    }
    
    func saveData() {
        do {
            try viewContext.save()
        } catch let error {
            print("Error while saving Events: \(error)")
        }
        fetchEvents()
    }
    
    func addEvent(withName name: String, andInformation information: String, andDate date: Date, andFavoriteStatus isFavorite: Bool, andRepeatStatus isRepeated: Bool) {
        let newEntity = EventEntity(context: viewContext)
        newEntity.eventID = UUID()
        newEntity.nameOfEvent = name
        newEntity.information = information
        newEntity.originalDate = date
        newEntity.isFavorite = isFavorite
        newEntity.isRepeated = isRepeated
        saveData()
    }
    
    func deleteEvent(_ event: Event) {
        let eventEntity = event.entity
        viewContext.delete(eventEntity)
        saveData()
    }
}
