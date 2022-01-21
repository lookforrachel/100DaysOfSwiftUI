//
//  ContentView.swift
//  WhosWho
//
//  Created by Rachel Yee on 1/10/22.
//

import SwiftUI

extension Image {
    
    public init?(data: Data?, placeholder: String) {
        guard let data = data,
              let uiImage = UIImage(data: data) else {
                  self = Image(placeholder)
                  return
              }
        self = Image(uiImage: uiImage)
    }
    
    func profilePhotoStyle() -> some View {
        
        self
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .frame(width: 100, height: 100)
    }
}

struct ContentView: View {
    @Environment(\.dismiss) var dismiss

    @StateObject var profiles = Profiles()
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
        
    @State private var name = ""
    @State private var location = ""
    @State private var description = ""
    
    @State private var showingImagePicker = false
    @State private var showingAddImageDetail = false
    @State private var newImageLoaded = false
            
    var body: some View {
        NavigationView {
                    List {
                        ForEach(profiles.profileItems) { profile in
                                NavigationLink {
                                    DetailView(profile: profile)
                                } label: {
                                    HStack {
                                        Image(data: profile.photo, placeholder: "Chickens")?
                                            .profilePhotoStyle()
                                        Text(profile.name)
                                    }
                                }
                            
                        }
                    }
            .toolbar {
                Button {
                    showingAddImageDetail = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .navigationTitle("Who's Who?")
            .sheet(isPresented: $showingAddImageDetail) {
                AddImageDetailView(profiles: profiles)
                }
            }
            .onChange(of: inputImage) { _ in
                loadImage()
//                showingAddImageDetail = true
                newImageLoaded = true
            }
        }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        image = Image(uiImage: inputImage)
    }
    
    func reset() {
        image = nil
        name = ""
        location = ""
        description = ""
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
