//
//  Prospect.swift
//  HotProspects
//
//  Created by Rachel Yee on 1/25/22.
//

import SwiftUI

class Prospect: Identifiable, Codable, Comparable {
    
    var id = UUID()
    var name = "Anonymous"
    var emailAddress = ""
    fileprivate (set) var isContacted = false
    
    static func < (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name < rhs.name
    }
    
    static func == (lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.id == rhs.id
    }
}

@MainActor class Prospects: ObservableObject {
    @Published private(set) var people: [Prospect]
//    let saveKey = "SavedData"
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedData")
    
//    init() {
//        if let data = UserDefaults.standard.data(forKey: saveKey) {
//            if let decoded = try? JSONDecoder().decode([Prospect].self, from: data) {
//                people = decoded
//                return
//            }
//        }
//        //no saved data
//        people = []
//    }
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            let decoded = try JSONDecoder().decode([Prospect].self, from: data)
            people = decoded.sorted()
        } catch {
            people = []
        }
    }
    
    func add(_ prospect: Prospect) {
        people.append(prospect)
        save()
    }
    
    private func save() {
//        if let encoded = try? JSONEncoder().encode(people) {
//            UserDefaults.standard.set(encoded, forKey: saveKey)
//        }
        do {
            let data = try JSONEncoder().encode(people)
            try data.write(to: savePath, options: [.atomicWrite])
        } catch {
            print("Unable to save data")
            print(error.localizedDescription)
        }
    }
    
    func toggle(_ prospect: Prospect) {
        objectWillChange.send()
        prospect.isContacted.toggle()
        save()
    }
}
