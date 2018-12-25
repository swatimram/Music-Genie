//
//  CoreDataStack.swift
//  MusicGenie
//
//  Created by Swati Maruthi Ram on 2/04/18.
//  Copyright © 2018 Swati. All rights reserved.
//

import Foundation
import CoreData

// MARK: - Core Data stack

public class MusicGenieCoreData {
    
    /// This function returns the singleton object where we store the data
    public class func sharedInstance() -> MusicGenieCoreData {
        struct Static {
            static let instance = MusicGenieCoreData()
        }
        return Static.instance
    }
    
    /// The directory the application uses to store the Core Data store file. This code uses a "documents" directory in the application's documents as storage path
    open lazy var applicationDocumentsDirectory: URL = {
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return urls[urls.count-1]
        
    }()
    
    /// The managed object model for the application. This property is not optional. It is a fatal error for the application not to be able to find and load its model.
    open lazy var managedObjectModel: NSManagedObjectModel = {
        let bundle = Bundle.init(for: type(of: self))
        let modelURL = bundle.url(forResource: "MusicGenie", withExtension: "momd")!
        return NSManagedObjectModel(contentsOf: modelURL)!
    }()
    
    // The persistent store coordinator for the application. This implementation creates and returns a coordinator, having added the store under documents directory for the application. This property is optional since there are legitimate error conditions that could cause the creation of the store to fail.
    open  lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator = {
        // Create the coordinator and store
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: MusicGenieCoreData.sharedInstance().managedObjectModel)
        let url = MusicGenieCoreData.sharedInstance().applicationDocumentsDirectory.appendingPathComponent("SingleViewCoreData.sqlite")
        var failureReason = "There was an error creating or loading the application's saved data."
        do {
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: nil)
        } catch {
            // Report any error we got.
            var dict = [String: AnyObject]()
            dict[NSLocalizedDescriptionKey] = "Failed to initialize the application's saved data" as AnyObject?
            dict[NSLocalizedFailureReasonErrorKey] = failureReason as AnyObject?
            
            dict[NSUnderlyingErrorKey] = error as NSError
            let wrappedError = NSError(domain: "YOUR_ERROR_DOMAIN", code: 9999, userInfo: dict)
            NSLog("Unresolved error \(wrappedError), \(wrappedError.userInfo)")
        }
        return coordinator
    }()
    
    // Returns the managed object context for the application (which is already bound to the persistent store coordinator for the application.) This property is optional since there are legitimate error conditions that could cause the creation of the context to fail.
    open lazy var managedObjectContext: NSManagedObjectContext = {
        let coordinator = MusicGenieCoreData.sharedInstance().persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    // MARK: - Core Data Saving support
    
    /// Functon which saves any changes in coredata
    public func saveContext() {
        if self.managedObjectContext.hasChanges {
            do {
                try self.managedObjectContext.save()
            } catch {
                let nserror = error as NSError
                NSLog("Unresolved error \(nserror), \(nserror.userInfo)")
                self.saveContext()
            }
        }
    }
    
    /// This function returns context in which data is saved
    public func getContext() -> NSManagedObjectContext {
        return  managedObjectContext
    }
    
}
