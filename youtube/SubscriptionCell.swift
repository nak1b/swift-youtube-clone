//
//  SubscriptionCell.swift
//  youtube
//
//  Created by Nakib on 12/28/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import UIKit

class SubscriptionCell: FeedCell {

    override func fetchVideos() {
        ApiService.sharedInstance.fetchSubscriptionVideos { (videos) in
            self.videos = videos
            
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }

}
