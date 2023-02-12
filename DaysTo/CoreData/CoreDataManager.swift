//
//  CoreDataManager.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 29.01.2023.
//
import CoreData

class CoreDataManager {
    let container: NSPersistentContainer
    
    static let shared = CoreDataManager()
    
    var viewContext: NSManagedObjectContext {
        return container.viewContext
    }
    
    init() {
        container = NSPersistentContainer(name: "DataContainer")
        container.loadPersistentStores { (description, error) in
            if let error = error {
                print("Error while loading DataContainer: \(error)")
            }
        }
    }
}
