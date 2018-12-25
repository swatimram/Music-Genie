//
//  Video+CoreDataProperties.swift
//  MusicGenie
//
//  Created by Swati Maruthi Ram on 7/04/18.
//  Copyright © 2018 Swati. All rights reserved.
//
//

import Foundation
import CoreData


extension Video {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Video> {
        return NSFetchRequest<Video>(entityName: "Video")
    }

    @NSManaged public var userId: String?
    @NSManaged public var instrument: String?
    @NSManaged public var isVisited: Bool
    @NSManaged public var isLiked: Bool
    @NSManaged public var isDisliked: Bool
    @NSManaged public var id: String?

}
