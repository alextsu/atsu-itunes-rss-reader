//
//  FavoritesTableViewController.swift
//  atsu-rss-reader
//
//  Created by Alexander Tsu on 12/17/15.
//  Copyright © 2015 Alexander Tsu. All rights reserved.
//

import UIKit

class FavoritesTableViewController: UITableViewController {
    var appEntries: [AppEntry]? = coreDataHelper.getFavorites()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(animated: Bool) {
        appEntries = coreDataHelper.getFavorites()
        self.tableView.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Potentially incomplete method implementation.
        // Return the number of sections.
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete method implementation.
        // Return the number of rows in the section.
        return self.appEntries!.count
    }
    
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("appCell", forIndexPath: indexPath) as! TableViewCell
        
        if let cellAppEntry : AppEntry = self.appEntries?[indexPath.row] {
            cell.appNameLabel.text = cellAppEntry.appName
            cell.categoryLabel.text = cellAppEntry.category
            
            
            //Note: For simplicity, the following implementation uses synchronous loading of UIImages
            //Note: For optimal performance, the icons can 1) be cached and 2) be loaded asynchronously via GCD
            let url = NSURL(string: cellAppEntry.iconLink)
            let data = NSData(contentsOfURL: url!)
            cell.appIconImageView.image = UIImage(data: data!)
            
        }
        
        
        return cell
    }
    
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let cell = sender as? UITableViewCell {
            
            if let indexPath = tableView!.indexPathForCell(cell) {
                let nextViewController = segue.destinationViewController as! AppDetailsViewController
                
                nextViewController.fromFavorites = true
                nextViewController.detailsAppEntry = self.appEntries?[indexPath.row]
            }
        }
    }
    
}
