//
//  ContentView.swift
//  BucketList
//
//  Created by Rachel Yee on 12/18/21.
//

import SwiftUI

struct User: Identifiable, Comparable {

    let id = UUID()
    let firstName: String
    let lastName: String

    static func < (lhs: User, rhs: User) -> Bool {
        lhs.lastName < rhs.lastName
    }
}

struct ContentView: View {
//    let values = [2,9,6,4,7].sorted()
    
    let users = [
        User(firstName: "Harry", lastName: "Potter"),
        User(firstName: "Ron", lastName: "Weasley"),
        User(firstName: "Hermione", lastName: "Granger")
    ].sorted()
    
    var body: some View {
//        List(values, id: \.self){
//            Text(String($0))
//        }
        
        List(users){ user in
            Text("\(user.firstName) \(user.lastName)")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
