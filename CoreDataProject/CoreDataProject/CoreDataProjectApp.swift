//
//  CoreDataProjectApp.swift
//  CoreDataProject
//
//  Created by Rachel Yee on 12/7/21.
//

import SwiftUI

@main
struct CoreDataProjectApp: App {
    @StateObject var dataController = DataController()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
