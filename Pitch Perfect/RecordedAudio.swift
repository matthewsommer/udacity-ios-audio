//
//  RecordedAudio.swift
//  Pitch Perfect
//
//  Created by Matt Sommer on 7/13/15.
//  Copyright (c) 2015 Matt Sommer. All rights reserved.
//

import Foundation

class RecordedAudio: NSObject{
    var filePathUrl: NSURL!
    var title: String!
    
    init(filePathUrl: NSURL,title: String) {
        self.filePathUrl = filePathUrl
        self.title = title
    }
}