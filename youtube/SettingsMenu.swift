//
//  SettingsMenu.swift
//  youtube
//
//  Created by Nakib on 12/24/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import UIKit

class SettingsMenu: NSObject {
    override init() {
        super.init()
    }
    
    let blackBG = UIView()
    
    let collectionView:UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = UIColor.white
        
        return cv
    }()
    
    func openMenu() {
        
        if let window = UIApplication.shared.keyWindow {
            
            blackBG.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(dismissMenu)))
            blackBG.backgroundColor = UIColor.init(white: 0, alpha: 0.5)
            blackBG.frame = window.frame
            blackBG.alpha = 0
            
            window.addSubview(blackBG)
            window.addSubview(collectionView)
            
            let height:CGFloat = 200
            let yPos = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)

            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackBG.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: yPos, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
        
    }
    
    func dismissMenu() {
        UIView.animate(withDuration: 0.5, animations: {
            self.blackBG.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }

        })
    }
}
