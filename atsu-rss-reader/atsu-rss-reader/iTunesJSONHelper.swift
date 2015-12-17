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
                        let link: String = ((entry["link"] as! NSDictionary)["attributes"] as! NSDictionary)["href"] as! String
                        let imageString : String = ((entry["im:image"] as! NSArray).objectAtIndex(2) as! NSDictionary)["label"] as! String
                    
                        
                        //Instantiate a new app entry and append it to the array
                        let appEntry:AppEntry = AppEntry(appName: appName, iconLink: imageString, summary: summary, category: category, releaseDate: releaseDate, creator: creator, link: link)
                        appEntries.append(appEntry)
                        
                        //TESTING
                        NSLog("Img URL: %@", imageString)
                        
                    }
                    
                }
            }
            
            
        }
        
        return appEntries
    }
}
