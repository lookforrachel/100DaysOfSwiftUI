//
//  Tag+CoreDataProperties.swift
//  Friendzy
//
//  Created by Rachel Yee on 12/11/21.
//
//

import Foundation
import CoreData


extension Tag {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Tag> {
        return NSFetchRequest<Tag>(entityName: "Tag")
    }

    @NSManaged public var tag: String?
    @NSManaged public var member: CachedUser?
    
    public var wrappedTag: String {
        tag ?? "unknown tag"
    }

}

extension Tag : Identifiable {

}
