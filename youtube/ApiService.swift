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
    
    let baseURL = "https://s3-us-west-2.amazonaws.com/youtubeassets/"
    
    func fetchVideos(completion: @escaping ([Video]) -> ()) {
        fetchVideosWithUrlString(urlString: "\(baseURL)home.json", completion: completion)
    }
    
    func fetchTrendingVideos(completion: @escaping ([Video]) -> ()) {
        fetchVideosWithUrlString(urlString: "\(baseURL)trending.json", completion: completion)
    }
    
    func fetchSubscriptionVideos(completion: @escaping ([Video]) -> ()) {
        fetchVideosWithUrlString(urlString: "\(baseURL)subscriptions.json", completion: completion)
    }

    func fetchVideosWithUrlString(urlString: String, completion: @escaping ([Video]) -> ()) {
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            do {
                if let unwrappedData = data, let jsonDictionry = try JSONSerialization.jsonObject(with: unwrappedData, options: .mutableContainers) as? [[String:AnyObject]] {
                    
                    let videos = jsonDictionry.map({return Video(dictionary: $0)})
                    
                    // Completing block
                    completion(videos)
                }
        
            } catch let jsonErr {
                print(jsonErr)
            }
            
        }).resume()
    }
    
}
