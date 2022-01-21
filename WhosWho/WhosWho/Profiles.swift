//
//  Profiles.swift
//  WhosWho
//
//  Created by Rachel Yee on 1/20/22.
//

import Foundation

class Profiles: ObservableObject {
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedProfiles")
    
    @Published var profileItems = [Profile]() {
        didSet {
            do {
                let data = try JSONEncoder().encode(profileItems)
                try data.write(to: savePath, options: [.atomicWrite])
            } catch {
                print("Unable to save data")
                print(error.localizedDescription)
            }
        }
    }
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            let decodedProfiles = try JSONDecoder().decode([Profile].self, from: data)
            profileItems = decodedProfiles.sorted()
        } catch {
            profileItems = []
        }
    }
}
