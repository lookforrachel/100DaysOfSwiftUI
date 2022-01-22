//
//  AddImageDetailView.swift
//  WhosWho
//
//  Created by Rachel Yee on 1/11/22.
//

import SwiftUI
import MapKit

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
    
    let locationFetcher = LocationFetcher()
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 1, longitude: 104), span: MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 1))
    @State private var selectedPlace: CLLocationCoordinate2D?
    @State private var locationType = "Current Location"
    @State private var locationTypes = ["Manual", "Current Location"]
    
    enum ImageSource {
    case camera, library
    }
    
    @State private var imageSource = ImageSource.library

    @State private var image: Image?
    @State private var inputImage: UIImage?
    
    @State private var name = ""
    @State private var location = ""
    @State private var description = ""
    @State private var latitude = 0.0
    @State private var longitude = 0.0
    
    @State private var showingImagePicker = false
    
    var isValidEntry: Bool {
        if name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty || locationType == "Manual" && location.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
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
                image?
                    .profilePhotoLargeStyle()
            }
            HStack{
                Button{
                    imageSource = .library
                    showingImagePicker = true
                    print("library")
                } label: {
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
                Button{
                    imageSource = .camera
                    showingImagePicker = true
                    print("camera")
                    
                }label: {
                    Image(systemName: "camera")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 30, height: 30)
                }
            }
            .sheet(isPresented: $showingImagePicker) {
//                ImagePicker(image: $inputImage)
                UIImagePicker(sourceType: imageSource == .library ? .photoLibrary : .camera, selectedImage: $inputImage)
            }
            .onChange(of: inputImage) {_ in loadImage()}

            VStack {
                TextField("Name", text: $name)
                    .font(.headline)
                TextField("Description", text: $description)
                
                Section {
                    Picker("Location Type:", selection: $locationType) {
                        ForEach(locationTypes, id: \.self) {
                            Text($0)
                        }
                    }
//                    .onChange(of: locationType) {
//                        if locationType =! "Manual" {
//                            location = ""
//                        } else { }
//                    }
                    
                    
                    TextField("Location (type in manually)", text: $location)
                        .disabled(locationType != "Manual")
                    
                    Button("Use current location") {
                        self.locationFetcher.start()
                        if let location = self.locationFetcher.lastKnownLocation {
                            selectedPlace = location
                            mapRegion = MKCoordinateRegion(center: selectedPlace ?? CLLocationCoordinate2D(latitude: 1, longitude: 104), span: MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 1))
                            print("Your location is \(location)")
                            print(selectedPlace ?? "unknown location")
                        } else {
                            print("Your location is unknown")
                        }
                    }
                    .disabled(locationType != "Current Location")
                }
                
                ZStack {
                    Map(coordinateRegion: $mapRegion)
                        .frame(width: 400, height: 100)
                    Circle()
                        .fill(.secondary)
                        .opacity(0.3)
                        .frame(width: 32, height: 32)
                }

                
            }
            .padding()
            
            HStack {
                Button("Cancel", role: .cancel){
                    image = nil
                    dismiss()
                }
                Button("Save") {
                    var newProfile = Profile(id: UUID(), name: name, location: location, latitude: mapRegion.center.latitude, longitude: mapRegion.center.longitude, description: description, locationTypeManual: locationType)
                    
                    if let jpegData = inputImage?.jpegData(compressionQuality: 0.8) {
                        newProfile.photo = jpegData
                    }
                    profiles.profileItems.append(newProfile)
                    reset()
                    dismiss()
                }
                .disabled(isValidEntry == false)
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
