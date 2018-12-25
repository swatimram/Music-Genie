//
//  UserProfile+CoreDataClass.swift
//  MusicGenie
//
//  Created by Swati Maruthi Ram on 13/04/18.
//  Copyright © 2018 Swati. All rights reserved.
//
//

import Foundation
import CoreData
import UIKit


public class UserProfile: NSManagedObject {

    class func saveUser(managedObjectContext: NSManagedObjectContext,userModel:UserModel)-> UserProfile {
        
        let userObject = NSEntityDescription.insertNewObject(forEntityName: "UserProfile", into: managedObjectContext) as! UserProfile
        
        userObject.name = userModel.name
        userObject.email = userModel.email
        userObject.interests = userModel.interest
        if let image = userModel.image {
            userObject.image = (UIImageJPEGRepresentation(image, 0.5)! as NSData)
        }
        userObject.location = userModel.location
        userObject.bio = userModel.bio
        
        return userObject
    }
    
    public class func fetchSavedObject(withRequest request: NSFetchRequest<UserProfile>, user : String)-> UserProfile? {
        let fetchRequest: NSFetchRequest<UserProfile> = request
        let predicate = NSPredicate(format: "email = %@", user as String)
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
