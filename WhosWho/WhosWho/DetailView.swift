//
//  DetailView.swift
//  WhosWho
//
//  Created by Rachel Yee on 1/18/22.
//

import SwiftUI
import MapKit

struct DetailView: View {
    
    let profile: Profile
    @State private var mapRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: 1, longitude: 104), span: MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 0))
    
    var body: some View {
        Image(data: profile.photo, placeholder: "Chickens")?
            .profilePhotoLargeStyle()

        Text("Name: \(profile.name)")
            .font(.headline)
        Text("Description: \(profile.description)")
        
        if profile.locationTypeManual == "Manual" {
            Text("Location: \(profile.location)")
        }
        
        if profile.locationTypeManual == "Current Location" {
            ZStack {
                Map(coordinateRegion: $mapRegion)
                    .frame(width: 400, height: 100)
                Image(systemName: "mappin.and.ellipse")
                    .foregroundColor(.red)
                    .frame(width: 32, height: 32)
            }
            .onAppear {
                mapRegion = MKCoordinateRegion(center: profile.locationCoordinates, span: MKCoordinateSpan(latitudeDelta: 0, longitudeDelta: 1))
            }
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(profile: Profile.example)
    }
}
