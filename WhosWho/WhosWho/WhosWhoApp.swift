//
//  WhosWhoApp.swift
//  WhosWho
//
//  Created by Rachel Yee on 1/10/22.
//

import SwiftUI

@main
struct WhosWhoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear{
                    UserDefaults.standard.setValue(false, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
                }
        }
    }
}
