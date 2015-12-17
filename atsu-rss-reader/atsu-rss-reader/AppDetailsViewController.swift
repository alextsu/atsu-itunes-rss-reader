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
    
    @IBOutlet weak var appIconImage: UIImageView!
    @IBOutlet weak var summaryLabel: UITextView!
    @IBOutlet weak var detailsLabel: UILabel!
    
    
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
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
