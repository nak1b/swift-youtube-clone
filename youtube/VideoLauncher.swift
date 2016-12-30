//
//  VideoLauncher.swift
//  youtube
//
//  Created by Nakib on 12/29/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import UIKit
import AVFoundation

class VideoPlayerView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = UIColor.black
        
        let urlStr = "https://firebasestorage.googleapis.com/v0/b/filestorage-5b34f.appspot.com/o/SampleVideo_1280x720_1mb.mp4?alt=media&token=bd2f92f8-a797-44f5-9892-0d931fdaf47e"
        
        if let url = URL(string: urlStr) {
            let player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player.play()
        }
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class VideoLauncher: NSObject {
    
    func launchVideo() {
        if let keyWindow = UIApplication.shared.keyWindow {
            let view = UIView()
            view.frame = CGRect(x: keyWindow.frame.width - 10, y: keyWindow.frame.height - 10, width: 10, height: 10)
            view.backgroundColor = UIColor.white
            
            //Video Player
            let height = keyWindow.frame.width * 9/16  // 9:16 Ratio
            let videoPlayerFrame = CGRect(x: 0, y: 0, width: keyWindow.frame.width, height: height)
            let videoPlayerView = VideoPlayerView(frame: videoPlayerFrame)
            view.addSubview(videoPlayerView)
            
            keyWindow.addSubview(view)
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: { 
                view.frame = keyWindow.frame
            }, completion: { (animationCompleted) in
                // after animation completion
                UIApplication.shared.isStatusBarHidden = true
            })
            
        }
    }
}
