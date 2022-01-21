//
//  AddImageDetailView.swift
//  WhosWho
//
//  Created by Rachel Yee on 1/11/22.
//

import SwiftUI

extension Image {
    func profilePhotoLargeStyle() -> some View {
        
        self
            .resizable()
            .scaledToFit()
            .clipShape(Circle())
            .frame(width: 300, height: 300)
    }
}

struct AddImageDetailView: View {
    @Environment(\.dismiss) var dismiss
    
    @ObservedObject var profiles: Profiles

    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    @State private var name = ""
    @State private var location = ""
    @State private var description = ""
    
    @State private var showingImagePicker = false
    var hasValidName: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return false
        }
        return true
    }
        
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedProfiles")
    
    var body: some View {
        VStack {
                Text("New Profile")
            ZStack {
                Circle()
                    .fill(.secondary)
                    .frame(width: 190, height: 190)
                Text("Select Image")
                image?
                    .profilePhotoLargeStyle()
            }
            .onTapGesture {
                showingImagePicker = true
            }
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $inputImage)
            }
            .onChange(of: inputImage) {_ in loadImage()}

            VStack {
                TextField("Name", text: $name)
                    .font(.headline)
                TextField("Location", text: $location)
                TextField("Description", text: $description)
            }
            .padding()
            
            HStack {
                Button("Cancel", role: .cancel){
                    image = nil
                }
                Button("Save") {
                    var newProfile = Profile(id: UUID(), name: name, location: location, description: description)
                    
                    if let jpegData = inputImage?.jpegData(compressionQuality: 0.8) {
                        newProfile.photo = jpegData
                    }
                    profiles.profileItems.append(newProfile)
                    reset()
                    dismiss()
                }
                .disabled(hasValidName == false)
            }
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

//struct AddImageDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        AddImageDetailView()
//    }
//}

        //        if image != nil {
        //            VStack {
        //                ZStack {
        //                    Rectangle()
        //                        .fill(.secondary)
        //                    image?
        //                        .resizable()
        //                        .scaledToFit()
        //                }
        //                TextField("Name", text: $name)
        //                    .font(.headline)
        //                TextField("Location", text: $location)
        //                TextField("Description", text: $description)
        //                HStack {
        //                    Button("Cancel", role: .cancel){
        //                        image = nil
        //                    }
        //                    Button("Save") {
        //                        var newProfile = Profile(id: UUID(), name: name, location: location, description: description)
        //
        //                        if let jpegData = inputImage?.jpegData(compressionQuality: 0.8) {
        //                            newProfile.photo = jpegData
        //                        }
        ////                                addNewProfile()
        //                        profiles.append(newProfile)
        ////                                save()
        //                        do {
        //                            let data = try JSONEncoder().encode(profiles)
        //                            try data.write(to: savePath, options: [.atomicWrite])
        //                        } catch {
        //                            print("Unable to save data")
        //                            print(error.localizedDescription)
        //                        }
        //
        //                        reset()
        //                    }
        //                }
        //            }
        //            .padding()
        //        }
        //    }
        //    init(profile: Profile) {
        //        self.profile = profile
        //
        //        _name = State(initialValue: profile.name)
        //        _location = State(initialValue: profile.location)
        //        _description = State(initialValue: profile.description)
        //    }
