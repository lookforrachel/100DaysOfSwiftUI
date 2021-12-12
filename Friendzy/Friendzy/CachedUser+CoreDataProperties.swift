//
//  CachedUser+CoreDataProperties.swift
//  Friendzy
//
//  Created by Rachel Yee on 12/11/21.
//
//

import Foundation
import CoreData


extension CachedUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CachedUser> {
        return NSFetchRequest<CachedUser>(entityName: "CachedUser")
    }

    @NSManaged public var about: String?
    @NSManaged public var address: String?
    @NSManaged public var age: Int16
    @NSManaged public var company: String?
    @NSManaged public var email: String?
    @NSManaged public var id: String?
    @NSManaged public var isActive: Bool
    @NSManaged public var name: String?
    @NSManaged public var registered: String?
    @NSManaged public var acquaintance: NSSet?
    @NSManaged public var interestGroup: NSSet?
    
    public var wrappedAbout: String {
        about ?? "unknown about"
    }
    
    public var wrappedAddress: String {
        address ?? "unknown address"
    }
    
    public var wrappedCompany: String {
        company ?? "unknown company"
    }
    
    public var wrappedEmail: String {
        email ?? "unknown email"
    }
    
    public var wrappedId: String {
        id ?? "unknown id"
    }
    
    public var wrappedName: String {
        name ?? "unknown name"
    }
    
    public var wrappedRegistered: String {
        registered ?? "unknown date"
    }
    
    public var acquaintanceArray: [CachedFriend] {
        let friendSet = acquaintance as? Set<CachedFriend> ?? []
        return friendSet.sorted {
            $0.wrappedName < $1.wrappedName
        }
    }
    
    public var interestGroupArray: [Tag] {
        let tagSet = interestGroup as? Set<Tag> ?? []
        
        return tagSet.sorted {
            $0.wrappedTag < $1.wrappedTag
        }
    }

}

// MARK: Generated accessors for acquaintance
extension CachedUser {

    @objc(addAcquaintanceObject:)
    @NSManaged public func addToAcquaintance(_ value: CachedFriend)

    @objc(removeAcquaintanceObject:)
    @NSManaged public func removeFromAcquaintance(_ value: CachedFriend)

    @objc(addAcquaintance:)
    @NSManaged public func addToAcquaintance(_ values: NSSet)

    @objc(removeAcquaintance:)
    @NSManaged public func removeFromAcquaintance(_ values: NSSet)

}

// MARK: Generated accessors for interestGroup
extension CachedUser {

    @objc(addInterestGroupObject:)
    @NSManaged public func addToInterestGroup(_ value: Tag)

    @objc(removeInterestGroupObject:)
    @NSManaged public func removeFromInterestGroup(_ value: Tag)

    @objc(addInterestGroup:)
    @NSManaged public func addToInterestGroup(_ values: NSSet)

    @objc(removeInterestGroup:)
    @NSManaged public func removeFromInterestGroup(_ values: NSSet)

}

extension CachedUser : Identifiable {

}
