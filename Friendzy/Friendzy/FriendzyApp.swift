//
//  FriendzyApp.swift
//  Friendzy
//
//  Created by Rachel Yee on 12/10/21.
//

import SwiftUI

@main
struct FriendzyApp: App {
    @StateObject var dataController = DataController()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, dataController.container.viewContext)
        }
    }
}
