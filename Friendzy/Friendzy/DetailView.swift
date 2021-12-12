//
//  DetailView.swift
//  Friendzy
//
//  Created by Rachel Yee on 12/10/21.
//

import SwiftUI

struct DetailView: View {
    @Environment(\.managedObjectContext) var moc
    
    let user: CachedUser
    
    var body: some View {
        VStack(alignment: .leading){
                Text(user.wrappedName)
                    .font(.title.bold())
                Text("Age: \(user.age)")
                Text("Company: \(user.wrappedCompany)")
                Text("Email: \(user.wrappedEmail)")
            
            Rectangle()
                .frame(height: 2)
                .padding()
            
            Text("Friends")
                .font(.headline)
                ForEach(user.acquaintanceArray) { friend in
                    Text(friend.wrappedName)
                }
            
        }
        .padding(.horizontal)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(user: CachedUser())
    }
}
