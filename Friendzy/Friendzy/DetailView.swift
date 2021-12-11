//
//  DetailView.swift
//  Friendzy
//
//  Created by Rachel Yee on 12/10/21.
//

import SwiftUI

struct DetailView: View {
    let user: User
    
    var body: some View {
        VStack{
            Section(user.name) {
                Text("Age: \(user.age)")
                Text(user.company)
                Text(user.email)
            }
            
            Section("Friends") {
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            }
        }
    }
}

//struct DetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        DetailView(user: User())
//    }
//}
