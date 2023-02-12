//
//  TagsCD.swift
//  DaysTo
//
//  Created by Danylo Ternovoi on 02.02.2023.
//

import CoreData

class TagsCD {
    
    func fetch() -> [TagEntity] {
        let request = NSFetchRequest<TagEntity>(entityName: "TagEntity")
        do {
            let fetchedTags = try CoreDataManager.shared.viewContext.fetch(request)
            return fetchedTags
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
    
    func add(name: String, color: String) {
        let newEntity = TagEntity(context: CoreDataManager.shared.viewContext)
        newEntity.name = name
        newEntity.color = color
        save()
    }
    
    func edit(_ tag: TagEntity, newName: String, newColor: String) {
        tag.name = newName
        tag.color = newColor
        save()
    }
    
    func delete(_ tag: TagEntity) {
        CoreDataManager.shared.viewContext.delete(tag)
        save()
    }
}
