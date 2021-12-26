//
//  FileManager-DocumentsDirectory.swift
//  BucketList
//
//  Created by Rachel Yee on 12/24/21.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}
