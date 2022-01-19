//
//  ContentView.swift
//  WhosWho
//
//  Created by Rachel Yee on 1/10/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.dismiss) var dismiss

    @State private var profiles = [Profile]()
    
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedProfiles")
    
    init() {
        do {
            let data = try Data(contentsOf: savePath)
            let decodedProfiles = try JSONDecoder().decode([Profile].self, from: data)
            _profiles = State(initialValue: decodedProfiles)
        } catch {
            _profiles = State(initialValue: [] )
        }
    }
    
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    @State private var newProfile = Profile(id: UUID(), name: "", location: "", description: "")
    
    @State private var name = ""
    @State private var location = ""
    @State private var description = ""
    
    @State private var showingImagePicker = false
    @State private var showingAddImageDetail = false
    @State private var newImageLoaded = false
            
    var body: some View {
        NavigationView {
            VStack {
                if image != nil {
                    VStack {
                        ZStack {
                            Rectangle()
                                .fill(.secondary)
                            image?
                                .resizable()
                                .scaledToFit()
                        }
                        TextField("Name", text: $name)
                            .font(.headline)
                        TextField("Location", text: $location)
                        TextField("Description", text: $description)
                        HStack {
                            Button("Cancel", role: .cancel){
                                image = nil
                            }
                            Button("Save") {
                                var newProfile = Profile(id: UUID(), name: name, location: location, description: description)
                                
                                if let jpegData = inputImage?.jpegData(compressionQuality: 0.8) {
                                    newProfile.photo = jpegData
                                }
//                                addNewProfile()
                                profiles.append(newProfile)
//                                save()
                                do {
                                    let data = try JSONEncoder().encode(profiles)
                                    try data.write(to: savePath, options: [.atomicWrite])
                                } catch {
                                    print("Unable to save data")
                                    print(error.localizedDescription)
                                }
                                    
                                reset()
                            }
                        }
                    }
                    .padding()
                }
                
                if image == nil {
                    List {
                        ForEach(profiles) { profile in
                                NavigationLink {
                                    DetailView(profile: profile)
                                } label: {
                                    HStack {
                                        Image(uiImage: UIImage(data: profile.photo!)!)
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: 50, height: 50)
                                        Text(profile.name)
                                    }
                                }
                            
                        }
                    }
                }
            }
            .toolbar {
                Button {
                    showingImagePicker = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .navigationTitle("Who's Who?")
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) { _ in
                loadImage()
//                showingAddImageDetail = true
                newImageLoaded = true
            }
            .sheet(isPresented: $showingAddImageDetail) {
                AddImageDetailView(profile: newProfile)
            }
        }
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        
        image = Image(uiImage: inputImage)
    }
    
    mutating func addNewProfile() {
        profiles.append(newProfile)
    }
    
    func save() {
        do {
            let data = try JSONEncoder().encode(profiles)
            try data.write(to: savePath, options: [.atomicWrite])
            let input = try Data(contentsOf: savePath)
            print(input)
        } catch {
            print("Unable to save data")
            print(error.localizedDescription)
        }
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
