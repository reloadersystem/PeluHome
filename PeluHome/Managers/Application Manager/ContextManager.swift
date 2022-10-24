//
//  ContextManager.swift
//  PeluHome
//
//  Created by Freddy Alexander Quispe Torres on 11/1/20.
//

import Foundation
import CoreData

class ContextManager {
    static let shared = ContextManager()

    var persistentContainer: NSPersistentContainer!
    var context:NSManagedObjectContext {
        return persistentContainer.viewContext
    }
        
    init() {
        persistentContainer = NSPersistentContainer(name: "PeluHome")
        persistentContainer.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
