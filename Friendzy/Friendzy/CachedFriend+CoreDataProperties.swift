//
//  CachedFriend+CoreDataProperties.swift
//  Friendzy
//
//  Created by Rachel Yee on 12/11/21.
//
//

import Foundation
import CoreData


extension CachedFriend {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedFriend> {
        return NSFetchRequest<CachedFriend>(entityName: "CachedFriend")
    }

    @NSManaged public var id: String?
    @NSManaged public var name: String?
    @NSManaged public var friend: CachedUser?
    
    public var wrappedId: String {
        id ?? "unknown id"
    }
    
    public var wrappedName: String {
        name ?? "unknown name"
    }
}

extension CachedFriend : Identifiable {

}
