//
//  Video+CoreDataClass.swift
//  MusicGenie
//
//  Created by Swati Maruthi Ram on 2/04/18.
//  Copyright © 2018 Swati. All rights reserved.
//
//

import Foundation
import CoreData


public class Video: NSManagedObject {

    
    class func createVideoModel(managedObjectContext: NSManagedObjectContext,videoID:String,userID:String,instrument:String)-> Video {
        
        let videoObject = NSEntityDescription.insertNewObject(forEntityName: "Video", into: managedObjectContext) as! Video
        
        videoObject.id = videoID
        videoObject.instrument = instrument
        videoObject.userId = userID
        videoObject.isVisited = false
        videoObject.isLiked = false
        videoObject.isDisliked = false
        
        return videoObject
    }
    
    // to track progress of course
    public class func fetchVideoObjectForInstrument(withRequest request: NSFetchRequest<Video>, userID:String,instrument:String)-> [Video]? {
        let fetchRequest: NSFetchRequest<Video> = request
        let predicate = NSPredicate(format: "userId = %@ && instrument = %@ ", userID as String,instrument as String)
        fetchRequest.predicate = predicate
        do {
            //go get the results
                return  try MusicGenieCoreData.sharedInstance().getContext().fetch(fetchRequest)
            }
         catch {
            print("error")
        }
        return nil
    }
    
    // like and dislike count
    public class func fetchVideoObjectBasedOnID(withRequest request: NSFetchRequest<Video>, videoID:String)-> [Video]? {
        let fetchRequest: NSFetchRequest<Video> = request
        let predicate = NSPredicate(format: "id = %@ ", videoID as String)
        fetchRequest.predicate = predicate
        do {
            //go get the results
            return  try MusicGenieCoreData.sharedInstance().getContext().fetch(fetchRequest)
        }
        catch {
            print("error")
        }
        return nil
    }
    
    //fetch video object based on user
    public class func fetchVideoObjectBasedOnIDForParticularUser(withRequest request: NSFetchRequest<Video>, videoID:String,userID:String)-> Video? {
        let fetchRequest: NSFetchRequest<Video> = request
        let predicate = NSPredicate(format: "id = %@ && userId = %@", videoID as String,userID as String)
        fetchRequest.predicate = predicate
        do {
            //go get the results
            if let user = try MusicGenieCoreData.sharedInstance().getContext().fetch(fetchRequest).first {
                return user
            }else {
                return nil
            }
        } catch {
            print("error")
        }
        return nil
    }
}
