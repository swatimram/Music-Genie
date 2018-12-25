//
//  UserProfile+CoreDataProperties.swift
//  MusicGenie
//
//  Created by Swati Maruthi Ram on 20/04/18.
//  Copyright © 2018 Swati. All rights reserved.
//
//

import Foundation
import CoreData


extension UserProfile {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<UserProfile> {
        return NSFetchRequest<UserProfile>(entityName: "UserProfile")
    }

    @NSManaged public var bio: String?
    @NSManaged public var email: String?
    @NSManaged public var image: NSData?
    @NSManaged public var interests: String?
    @NSManaged public var location: String?
    @NSManaged public var name: String?

}
