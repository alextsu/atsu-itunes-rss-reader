//
//  CoreDataHelper.swift
//  atsu-rss-reader
//
//  Created by Alexander Tsu on 12/17/15.
//  Copyright © 2015 Alexander Tsu. All rights reserved.
//

import UIKit
import CoreData

let coreDataHelper = CoreDataHelper()

public class CoreDataHelper: NSObject {
    
    
    func getFavorites() -> [AppEntry]? {
        
        var appEntries = [AppEntry]()
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let fetchRequest = NSFetchRequest(entityName:"AppEntry")
        
 
        let fetchedResults: [NSManagedObject]!
        
        do {
            fetchedResults = try managedContext.executeFetchRequest(fetchRequest) as? [NSManagedObject]
        } catch let error as NSError {
            print("Fetch failed: \(error.localizedDescription)")
            return nil
        }
        
        for appEntryManagedObject in fetchedResults {
            
            let appName: String = appEntryManagedObject.valueForKey("appname") as! String
            let summary: String = appEntryManagedObject.valueForKey("summary") as! String
            let category: String = appEntryManagedObject.valueForKey("category") as! String
            let releaseDate: String = appEntryManagedObject.valueForKey("releasedate") as! String
            let creator: String = appEntryManagedObject.valueForKey("creator") as! String
            let link: String = appEntryManagedObject.valueForKey("link") as! String
            let iconLink: String = appEntryManagedObject.valueForKey("iconlink") as! String
            
            //Instantiate a new app entry and append it to the array
            let appEntry:AppEntry = AppEntry(appName: appName, iconLink: iconLink, summary: summary, category: category, releaseDate: releaseDate, creator: creator, link: link)
            appEntries.append(appEntry)
            
        }
        
        
        return appEntries
    }
    
    func addToFavorites(app: AppEntry) -> Bool{
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext!
        let entity = NSEntityDescription.entityForName("AppEntry", inManagedObjectContext: managedContext)
        let appEntryManagedObject = NSManagedObject(entity: entity!, insertIntoManagedObjectContext: managedContext)
        
        appEntryManagedObject.setValue(app.appName, forKey: "appname")
        appEntryManagedObject.setValue(app.category, forKey: "category")
        appEntryManagedObject.setValue(app.creator, forKey: "creator")
        appEntryManagedObject.setValue(app.iconLink, forKey: "iconlink")
        appEntryManagedObject.setValue(app.link, forKey: "link")
        appEntryManagedObject.setValue(app.releaseDate, forKey: "releasedate")
        appEntryManagedObject.setValue(app.summary, forKey: "summary")
        
        do {
            try managedContext.save()
        } catch {
            print("Failure to save context: \(error)")
            return false
        }
        
        return true
    }
}
