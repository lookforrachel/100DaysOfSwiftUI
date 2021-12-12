//
//  ContentView.swift
//  Friendzy
//
//  Created by Rachel Yee on 12/10/21.
//

import SwiftUI

struct Response: Codable {
    var users: [UserStruct]
}

struct ContentView: View {
    @Environment(\.managedObjectContext) var moc
    @FetchRequest(sortDescriptors: [SortDescriptor(\.name)]) var fetchedUsers: FetchedResults<CachedUser>
    
    @State private var users = [UserStruct]()
    
    var body: some View {

            NavigationView {
                VStack {
                    List(fetchedUsers) { user in
                        NavigationLink {
                            DetailView(user: user)
                        } label: {
                            VStack(alignment: .leading) {
                                Text(user.wrappedName)
                                    .font(.headline)
                                Text(user.wrappedCompany)
                            }
                        }
                    }
                    .task {
                            if users.isEmpty {
                                await loadData()
                                print("Users array has: \(users.count) users")

                                if fetchedUsers.isEmpty {
                                    saveData(data: users)
                                    print("Core Data is empty: \(fetchedUsers.count)")
                                }
                            }
                    }
                    Button("No. of users in array"){
                        print("No. of users in array: \(users.count)")
                    }

                    Button("No. of users in Core Data"){
                        print("No. of users in Core Data: \(fetchedUsers.count)")
                    }
                }
            }
        
    }
    
    func loadData() async {
            guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
                print("Invalid URL")
                return
            }

              do {
                let (data, _) = try await URLSession.shared.data(from: url)
                    
                let decodedResponse = try JSONDecoder().decode([UserStruct].self, from: data)
                DispatchQueue.main.async {
                  self.users = decodedResponse
                    print("\(self.users.count) users just saved in array ")
                    saveData(data: users)
                 }
                  
              } catch DecodingError.keyNotFound(let key, let context) {
                  Swift.print("could not find key \(key) in JSON: \(context.debugDescription)")
              } catch DecodingError.valueNotFound(let type, let context) {
                  Swift.print("could not find type \(type) in JSON: \(context.debugDescription)")
              } catch DecodingError.typeMismatch(let type, let context) {
                  Swift.print("type mismatch for type \(type) in JSON: \(context.debugDescription)")
              } catch DecodingError.dataCorrupted(let context) {
                  Swift.print("data found to be corrupted in JSON: \(context.debugDescription)")
              } catch let error as NSError {
                  NSLog("Error in read(from:ofType:) domain= \(error.domain), description= \(error.localizedDescription)")
              }

              return
        
    }
    
    func saveData(data: [UserStruct]) {
        
        print("saving data into Core Data")

            for user in data {
                print("saving \(user)")
                let cachedUser = CachedUser(context: moc)
                cachedUser.id = user.id
                cachedUser.isActive = user.isActive
                cachedUser.name = user.name
                cachedUser.age = Int16(user.age)
                cachedUser.company = user.company
                cachedUser.email = user.email
                cachedUser.address = user.address
                cachedUser.about = user.about
                cachedUser.registered = user.registered
//                cachedUser.interestGroupArray = user.tags
                
                for friend in user.friends {
                    let cachedFriends = CachedFriend(context: moc)
                    cachedFriends.name = friend.name
                    cachedFriends.id = friend.id
                }
                
//                ForEach(user.tags) { tag in
//                    let tags = Tag(context: moc)
//                    tags.tag = tag.tag
//                }
                try? moc.save()
            }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
