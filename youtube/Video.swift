//
//  Video.swift
//  youtube
//
//  Created by Nakib on 12/17/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import UIKit

class Video: NSObject {
    var thumbnailImageName: String?
    var title: String?
    var numberOfViews: NSNumber? = 0.0
    var uploadDate: NSDate?
    
    var channel: Channel?
}


class Channel: NSObject {
    var name: String?
    var profileImage: String?
}
