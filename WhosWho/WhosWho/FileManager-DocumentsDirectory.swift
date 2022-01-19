//
//  FileManager-DocumentsDirectory.swift
//  WhosWho
//
//  Created by Rachel Yee on 1/12/22.
//

import Foundation

extension FileManager {
    static var documentsDirectory: URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
            return paths[0]
    }
}
