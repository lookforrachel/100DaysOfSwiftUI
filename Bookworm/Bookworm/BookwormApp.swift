//
//  BookwormApp.swift
//  Bookworm
//
//  Created by Rachel Yee on 12/3/21.
//

import SwiftUI

@main
struct BookwormApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
