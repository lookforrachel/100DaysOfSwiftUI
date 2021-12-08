//
//  DataController.swift
//  CoreDataProject
//
//  Created by Rachel Yee on 12/7/21.
//

import CoreData
import Foundation

class DataController : ObservableObject {
    let container = NSPersistentContainer(name: "CoreDataProject")
    
    init() {
        container.loadPersistentStores { description, error in
            if let error = error {
                print("Core Data failed to load: \(error.localizedDescription)")
            }
        }
    }
}
