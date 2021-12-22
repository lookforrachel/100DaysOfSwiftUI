//
//  ContentView.swift
//  BucketList
//
//  Created by Rachel Yee on 12/18/21.
//

import SwiftUI

struct ContentView: View {
    
    @State private var postsUnavailable = true
    
    var body: some View {
        NavigationView {
            VStack{
                Text("Save Data")
                    .onTapGesture {
                        let apiResponse = """
                                          [
                                              {
                                                  "title": "Easy Reading and Writing String to and from file in Swift",
                                                  "date": "2021-05-11"
                                              },
                                              {
                                                  "title": "Post 2",
                                                  "date": "2021-05-04"
                                              }
                                          ]
                                          """
                        let url = getDocumentDirectory().appendingPathComponent("blog.txt")
                        do {
                            try apiResponse.write(to:url, atomically: true, encoding: .utf8)
                            
                            let input = try String(contentsOf: url)
                            print(input)
                            postsUnavailable = false

                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                    NavigationLink {
                        BlogView()
                    } label: {
                        Text("Show Blog Posts")
                    }.disabled(postsUnavailable)
                
                
            }
        }
    }
    
    func getDocumentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
}

//struct ContentView_Previews: PreviewProvider {
//    static var previews: some View {
//        ContentView()
//    }
//}
