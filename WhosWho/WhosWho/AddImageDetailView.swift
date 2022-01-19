//
//  AddImageDetailView.swift
//  WhosWho
//
//  Created by Rachel Yee on 1/11/22.
//

import SwiftUI

struct AddImageDetailView: View {
    var profile: Profile
    
    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    @State private var name: String
    @State private var location: String
    @State private var description: String
    
    @State private var showingImagePicker = false
    
    var body: some View {
        VStack {
            HStack {
                Text("Add Image Detail View")
                Button {
                    showingImagePicker = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            ZStack {
                Rectangle()
                    .fill(.secondary)
                image?
                    .resizable()
                    .scaledToFit()
            }

            VStack {
                TextField("Name", text: $name)
                    .font(.headline)
                TextField("Location", text: $location)
                TextField("Description", text: $description)
            }
            .padding()
        }
        .sheet(isPresented: $showingImagePicker) {
            ImagePicker(image: $inputImage)
        }
        .onChange(of: inputImage) {_ in loadImage()}
    }
    init(profile: Profile) {
        self.profile = profile
        
        _name = State(initialValue: profile.name)
        _location = State(initialValue: profile.location)
        _description = State(initialValue: profile.description)
    }
    
    func loadImage() {
        guard let inputImage = inputImage else { return }
        image = Image(uiImage: inputImage)
    }
}

struct AddImageDetailView_Previews: PreviewProvider {
    static var previews: some View {
        AddImageDetailView(profile: Profile.example)
    }
}
