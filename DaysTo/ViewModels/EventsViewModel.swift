//
//  EventsViewModel.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 22.01.2023.
//

import Foundation
import CoreData

class EventsViewModel: ObservableObject {
    
    @Published var events: [EventEntity] = []
    @Published var tags: [TagEntity] = []
    let container: NSPersistentContainer
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    init() {
        container = NSPersistentContainer(name: "EventsContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error while loading EventsContainer: \(error)")
            }
        }
        fetchData()
    }
    
    func fetchData() {
        let requestEvents = NSFetchRequest<EventEntity>(entityName: "EventEntity")
        let requestTags = NSFetchRequest<TagEntity>(entityName: "TagEntity")
        do {
            events = try viewContext.fetch(requestEvents)
            tags = try viewContext.fetch(requestTags)
        } catch let error {
            print("Error while fetch Events: \(error)")
        }
    }
    
    func saveData() {
        do {
            try viewContext.save()
            fetchData()
        } catch let error {
            print("Error while saving Events: \(error)")
        }
    }
    
    func addEvent(name: String, description: String, date: Date, repeatAnnual: Bool, isFavorite: Bool) {
        let newEvent = EventEntity(context: viewContext)
        newEvent.name = name
        newEvent.info = description
        newEvent.date = date
        newEvent.repeatAnnual = repeatAnnual
        newEvent.favorite = isFavorite
        saveData()
    }
    
    func addTag(name: String, color: String) {
        let newTag = TagEntity(context: viewContext)
        newTag.name = name
        newTag.color = color
        saveData()
    }
    
    func deleteEvent(withIndex IndexSet: IndexSet) {
        guard let eventIndex = IndexSet.first else { return }
        let event = events[eventIndex]
        viewContext.delete(event)
        saveData()
    }
    
    func deleteTag(withIndex IndexSet: IndexSet) {
        guard let tagIndex = IndexSet.first else { return }
        let tag = tags[tagIndex]
        viewContext.delete(tag)
        saveData()
    }
}
