//
//  ApiService.swift
//  youtube
//
//  Created by Nakib on 12/27/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import UIKit

class ApiService: NSObject {
    static let sharedInstance = ApiService()
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                var videos = [Video]()
                
                for dictionary in json as! [[String:AnyObject]] {
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDict = dictionary["channel"] as! [String:AnyObject]
                    
                    let channel = Channel()
                    channel.profileImage = channelDict["profile_image_name"] as? String
                    channel.name = channelDict["name"] as? String
                    
                    video.channel = channel
                    
                    videos.append(video)
                }
                
                // Completing block
                completion(videos)
                
            } catch let jsonErr {
                print(jsonErr)
            }
            
        }).resume()
    }

    
}
