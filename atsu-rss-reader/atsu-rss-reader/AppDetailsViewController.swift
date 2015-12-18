//
//  AppDetailsViewController.swift
//  atsu-rss-reader
//
//  Created by Alexander Tsu on 12/17/15.
//  Copyright (c) 2015 Alexander Tsu. All rights reserved.
//

import UIKit

class AppDetailsViewController: UIViewController {

    var detailsAppEntry : AppEntry!
    var fromFavorites : Bool!
    
    @IBOutlet weak var appIconImage: UIImageView!
    @IBOutlet weak var summaryLabel: UITextView!
    @IBOutlet weak var detailsLabel: UILabel!
    @IBOutlet weak var saveToFavoritesButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = detailsAppEntry.appName
        
        //set the app icon image
        let url = NSURL(string: detailsAppEntry.iconLink)
        let data = NSData(contentsOfURL: url!)
        self.appIconImage.image = UIImage(data: data!)
        
        //set the summary text
        self.summaryLabel.text = detailsAppEntry.summary
        
        //set the additional details
        self.detailsLabel.text = detailsAppEntry.category + " // " + detailsAppEntry.releaseDate + " // " + detailsAppEntry.creator
        
        //if we're coming from the favorites table view, remove the option to save to favorites
        if fromFavorites == true {
            self.saveToFavoritesButton.enabled = false
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func appStoreLink(sender: UIBarButtonItem) {
        UIApplication.sharedApplication().openURL(NSURL(string:detailsAppEntry.link)!)
    }
    
    @IBAction func saveToFavorites(sender: UIBarButtonItem) {
        let saveSuccess = coreDataHelper.addToFavorites(detailsAppEntry)
        
        //If Save was unsuccessful, present a UIAlert informing user there was an error or the element is already a Favorite
        if saveSuccess == false {
            
            let alert = UIAlertController(title: "Error", message: "This item could not be added to Favorites. Either the item is already a Favorite or something went wrong.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
    }
    
    

}
