//
//  ContentView.swift
//  Friendzy
//
//  Created by Rachel Yee on 12/10/21.
//

import SwiftUI

struct Response: Codable {
    var users: [User]
}

struct ContentView: View {
    @State private var users = [User]()
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink {
                    DetailView(user: user)
                } label: {
                    VStack(alignment: .leading) {
                        Text(user.name)
                            .font(.headline)
                        Text(user.company)
                    }
                }
            }
            .task {
                if users.isEmpty {
                    await loadData()
                }
            }
        }
    }
    
    func loadData() async {
        guard let url = URL(string: "https://www.hackingwithswift.com/samples/friendface.json") else {
            print("Invalid URL")
            return
        }
        
//        do {
//            let (data, _) = try await URLSession.shared.data(from: url)
//
//            if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
//                users = decodedResponse.users
//            }
//
//        } catch let jsonError as NSError {
//            print("Invalid Data \(jsonError.localizedDescription)")
//        }
        
         
          do {
            let (data, _) = try await URLSession.shared.data(from: url)
                
            let decodedResponse = try JSONDecoder().decode([User].self, from: data)
            DispatchQueue.main.async {
              self.users = decodedResponse
             }
//          } catch let jsonError as NSError {
//            print("JSON decode failed: \(jsonError.localizedDescription)")
//          }
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
