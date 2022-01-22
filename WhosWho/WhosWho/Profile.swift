//
//  Profile.swift
//  WhosWho
//
//  Created by Rachel Yee on 1/11/22.
//

import Foundation
import CoreLocation

struct Profile: Identifiable, Codable, Equatable, Comparable {
    
    var id: UUID
    var name: String
    var location: String
    var latitude: Double
    var longitude: Double
    var description: String
    var photo: Data?
    
    var locationTypeManual: String
    
    var locationCoordinates: CLLocationCoordinate2D {
        CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
    }
    
    static let example = Profile(id: UUID(), name: "John Appleseed", location: "Comic Con 2021", latitude: 37.785834, longitude: -122.406417, description: "Guy in Spiderman costume", locationTypeManual: "Manual")
    
    static func == (lhs: Profile, rhs: Profile) -> Bool {
        lhs.id == rhs.id
    }
    
    static func < (lhs: Profile, rhs: Profile) -> Bool {
        lhs.name < rhs.name
    }
}


