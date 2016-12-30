//
//  Video.swift
//  youtube
//
//  Created by Nakib on 12/17/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import UIKit

class Video: NSObject {
    var thumbnail_image_name: String?
    var title: String?
    var number_of_views: NSNumber? = 0.0
    var uploadDate: NSDate?
    var duration: NSNumber?
    
    var channel: Channel?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if(key == "channel") {
            self.channel = Channel()
            self.channel?.setValuesForKeys(value as! [String: Any])
        } else {
            super.setValue(value, forKey: key)
        }
    }
    
    init(dictionary: [String:AnyObject]) {
        super.init()
        setValuesForKeys(dictionary)
    }
}


class Channel: NSObject {
    var name: String?
    var profile_image_name: String?
}
