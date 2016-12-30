//
//  Video.swift
//  youtube
//
//  Created by Nakib on 12/17/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import UIKit

class SafeJSON: NSObject {
    
    // Preventing crash when new key:value property is introduced
    // on the server side
    override func setValue(_ value: Any?, forKey key: String) {
        let upperCaseFirstLetter = String(key.characters.first!).uppercased()
        let range = NSMakeRange(0, 1)
        let selectorStr = NSString(string: key).replacingCharacters(in: range, with: upperCaseFirstLetter)
        
        let selector = NSSelectorFromString("set\(selectorStr):")
        let response = self.responds(to: selector)
        
        if !response {
            return
        }
        
        super.setValue(value, forKey: key)
    }
}

class Video: SafeJSON {
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


class Channel: SafeJSON {
    var name: String?
    var profile_image_name: String?
}
