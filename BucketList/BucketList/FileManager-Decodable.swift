//
//  FileManager-Decodable.swift
//  BucketList
//
//  Created by Rachel Yee on 12/19/21.
//

import Foundation

extension FileManager {
    func decode(_ file: String) -> String {
        
        let url = getDocumentDirectory().appendingPathComponent(file)
        
        guard let data = try? String(contentsOf: url) else {
            fatalError("Failed to load \(file) from file directory")
        }
        
        return data

    }
    
    func getDocumentDirectory() -> URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
    
}
