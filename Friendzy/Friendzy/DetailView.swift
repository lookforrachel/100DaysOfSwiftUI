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
        VStack(alignment: .leading){
                Text(user.name)
                    .font(.title.bold())
                Text("Age: \(user.age)")
                Text("Company: \(user.company)")
                Text("Email: \(user.email)")
            
            Rectangle()
                .frame(height: 2)
                .padding()
            
            Text("Friends")
                .font(.headline)
                ForEach(user.friends) { friend in
                    Text(friend.name)
                }
            
        }
        .padding(.horizontal)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(user: User(id: "1111111", isActive: true, name: "John Appleseed", age: 20, company: "Apple", email: "john.appleseed@mac.com", address: "111 Apple St", about: "sfsdfdsfsd", registered: "xxx", tags: ["tag 1", "tag 2", "tag 3", "tag 4"], friends: [Friend(id: "123143", name: "Steve Jobs")]))
    }
}
