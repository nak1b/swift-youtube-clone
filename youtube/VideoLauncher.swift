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
    
    let activitityIndicatorView: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        
        return spinner
    }()
    
    lazy var playPauseButton: UIButton = {
        let button = UIButton(type: .system)
        let image = UIImage(named: "pause")
        button.setImage(image, for: .normal)
        button.tintColor = UIColor.white
        button.isHidden = true
        button.addTarget(self, action: #selector(handlePlay), for: .touchUpInside)
        
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    var isPlaying = false
    func handlePlay() {
        if isPlaying {
            player?.pause()
            playPauseButton.setImage(UIImage(named: "play"), for: .normal)
        } else {
            player?.play()
            playPauseButton.setImage(UIImage(named: "pause"), for: .normal)
        }
        
        isPlaying = !isPlaying
        
    }
    
    let controlsContainer: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.init(white: 0, alpha: 1)
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPlayerView()
        
        backgroundColor = UIColor.black
        
        controlsContainer.frame = self.frame
        addSubview(controlsContainer)
        
        controlsContainer.addSubview(activitityIndicatorView)
        activitityIndicatorView.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        activitityIndicatorView.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        
        controlsContainer.addSubview(playPauseButton)
        playPauseButton.centerXAnchor.constraint(equalTo: self.centerXAnchor, constant: 0).isActive = true
        playPauseButton.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: 0).isActive = true
        playPauseButton.heightAnchor.constraint(equalToConstant: 50)
        playPauseButton.widthAnchor.constraint(equalToConstant: 50)
        
    }
    
    var player: AVPlayer?
    
    func setupPlayerView() {
        let urlStr = "https://firebasestorage.googleapis.com/v0/b/filestorage-5b34f.appspot.com/o/SampleVideo_1280x720_1mb.mp4?alt=media&token=bd2f92f8-a797-44f5-9892-0d931fdaf47e"
        
        if let url = URL(string: urlStr) {
            player = AVPlayer(url: url)
            
            let playerLayer = AVPlayerLayer(player: player)
            self.layer.addSublayer(playerLayer)
            playerLayer.frame = self.frame
            
            player?.play()
            
            player?.addObserver(self, forKeyPath: "currentItem.loadedTimeRanges", options: .new, context: nil)
        }

    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
        //when player is ready
        if keyPath == "currentItem.loadedTimeRanges" {
            activitityIndicatorView.stopAnimating()
            controlsContainer.backgroundColor = UIColor.clear
            playPauseButton.isHidden = false
            isPlaying = true
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
