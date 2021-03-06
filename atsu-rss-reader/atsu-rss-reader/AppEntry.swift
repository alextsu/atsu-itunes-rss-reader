//
//  AppEntry.swift
//  atsu-rss-reader
//
//  Created by Alexander Tsu on 12/16/15.
//  Copyright (c) 2015 Alexander Tsu. All rights reserved.
//

import UIKit

//App Entry object with all variables

class AppEntry: NSObject {
    var appName: String
    var iconLink: String
    var summary: String
    var category: String
    var releaseDate: String
    var creator: String
    var link: String
    
    init (appName: String, iconLink: String, summary: String, category: String, releaseDate: String, creator: String, link: String) {
        self.appName = appName
        self.iconLink = iconLink
        self.summary = summary
        self.category = category
        self.releaseDate = releaseDate
        self.creator = creator
        self.link = link
    }
}
