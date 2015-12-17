//
//  iTunesJSONHelper.swift
//  atsu-rss-reader
//
//  Created by Alexander Tsu on 12/16/15.
//  Copyright (c) 2015 Alexander Tsu. All rights reserved.
//

import UIKit

let feedURL = "https://itunes.apple.com/us/rss/topgrossingapplications/limit=50/json"
let itunesHelper = iTunesJSONHelper()

public class iTunesJSONHelper: NSObject {
   
    func getFeed() -> [AppEntry]? {
        
        var appEntries = [AppEntry]()
        
        //convert URL to NSURL then to NSData
        let feedData:NSData? = NSData(contentsOfURL: NSURL(string: feedURL)!)
        
        //parse JSON using NSJSONSerialization and convert to NSDictionary
        if let feedDictionary: NSDictionary = NSJSONSerialization.JSONObjectWithData(feedData!, options: NSJSONReadingOptions.MutableContainers, error: nil) as? NSDictionary {
            
            //dive down into the array of entries
            if let feed = feedDictionary["feed"] as? NSDictionary {
                if let entries = feed["entry"] as? NSArray {
                    

                    for entry in entries {
                        
                        //For the string properties, drill down and store these labels as constants for readability
                        let appName: String = (entry["im:name"] as! NSDictionary)["label"] as! String
                        let summary: String = (entry["summary"] as! NSDictionary)["label"] as! String
                        let category: String = ((entry["category"] as! NSDictionary)["attributes"] as! NSDictionary)["label"] as! String
                        let releaseDate: String = ((entry["im:releaseDate"] as! NSDictionary)["attributes"] as!NSDictionary)["label"] as! String
                        let creator: String = (entry["im:artist"] as! NSDictionary)["label"] as! String
                        
                        //For the image, load a url into a UIImage to be stored in the AppEntry model
                        //Note: For simplicity, I'm making a choice to do this synchronously.
                        //Note: If there were a greater number or larger images, I'd consider using GCD here to handle in background thread
                        let imageString : String = ((entry["im:image"] as! NSArray).objectAtIndex(2) as! NSDictionary)["label"] as! String
                        let appImage : UIImage = UIImage(data: NSData(contentsOfURL: NSURL(string: imageString)!)!)!
                    
                        //Instantiate a new app entry and append it to the array
                        let appEntry:AppEntry = AppEntry(appName: appName, icon: appImage, summary: summary, category: category, releaseDate: releaseDate, creator: creator)
                        appEntries.append(appEntry)
                        
                        //TESTING
                        //NSLog("Image URL: %@", imageString)
                        
                    }
                    
                }
            }
            
            
        }
        
        return appEntries
    }
}
