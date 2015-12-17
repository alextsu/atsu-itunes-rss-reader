//
//  AppEntry.swift
//  atsu-rss-reader
//
//  Created by Alexander Tsu on 12/16/15.
//  Copyright (c) 2015 Alexander Tsu. All rights reserved.
//

import UIKit

class AppEntry: NSObject {
    var appName: String
    var icon: UIImage
    var summary: String
    var category: String
    var releaseDate: String
    var creator: String
    var link: String
    
    init (appName: String, icon: UIImage, summary: String, category: String, releaseDate: String, creator: String, link: String) {
        self.appName = appName
        self.icon = icon
        self.summary = summary
        self.category = category
        self.releaseDate = releaseDate
        self.creator = creator
        self.link = link
    }
}
