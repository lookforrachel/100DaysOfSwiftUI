//
//  Favourites.swift
//  SnowSeeker
//
//  Created by Rachel Yee on 3/24/22.
//

import Foundation

class Favorites: ObservableObject {
    private var resorts: Set<String>
    private let saveKey = "Favorites"
        
    init() {
        //load our saved data
        if let savedResorts = UserDefaults.standard.data(forKey: "Favorites") {
            if let decodedResorts = try? JSONDecoder().decode(Set<String>.self, from: savedResorts) {
                resorts = decodedResorts
                return
            }
        }
        resorts = []
    }
    
    func contains(_ resort: Resort) -> Bool {
        resorts.contains(resort.id)
    }
    
    func add(_ resort: Resort) {
        objectWillChange.send()
        resorts.insert(resort.id)
        save()
    }
    
    func remove(_ resort: Resort) {
        objectWillChange.send()
        resorts.remove(resort.id)
        save()
    }
    
    func save() {
        // write out our data
        let encoder = JSONEncoder()
        
        if let encoded = try? encoder.encode(resorts) {
            UserDefaults.standard.set(encoded, forKey: "Favorites")
        }
    }
}
