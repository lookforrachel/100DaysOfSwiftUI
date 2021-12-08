//
//  Singer+CoreDataProperties.swift
//  CoreDataProject
//
//  Created by Rachel Yee on 12/7/21.
//
//

import Foundation
import CoreData


extension Singer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Singer> {
        return NSFetchRequest<Singer>(entityName: "Singer")
    }

    @NSManaged public var lastName: String?
    @NSManaged public var firstName: String?
    
    var wrappedLastName: String {
        lastName ?? "Unknown"
    }
    
    var wrappedFirstName: String {
        firstName ?? "Unknown"
    }

}

extension Singer : Identifiable {

}
