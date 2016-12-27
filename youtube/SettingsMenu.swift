//
//  SettingsMenu.swift
//  youtube
//
//  Created by Nakib on 12/24/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import UIKit


class Setting: NSObject {
    let name:String
    let iconName:String
    
    init(name:String, iconName:String) {
        self.name = name
        self.iconName = iconName
    }
}


class SettingsMenu: NSObject, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    let cellHeight:CGFloat = 50
    let blackBG = UIView()
    var homeController: HomeController?
    
    let settings:[Setting] = {
        return [
            Setting(name: "Settings", iconName: "settings"),
            Setting(name: "Terms & privacy policy", iconName: "privacy"),
            Setting(name: "Send Feedback", iconName: "feedback"),
            Setting(name: "Help", iconName: "help"),
            Setting(name: "Switch account", iconName: "switch_account"),
            Setting(name: "Cancel", iconName: "cancel")
        ]
    }()
    
    override init() {
        super.init()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(SettingsCell.self, forCellWithReuseIdentifier: cellId)
    }
    
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
            
            let height:CGFloat = CGFloat(settings.count) * cellHeight
            let yPos = window.frame.height - height
            collectionView.frame = CGRect(x: 0, y: window.frame.height, width: window.frame.width, height: height)

            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.blackBG.alpha = 1
                self.collectionView.frame = CGRect(x: 0, y: yPos, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }, completion: nil)
        }
        
    }
    
    func dismissMenu(setting: Setting) {
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.blackBG.alpha = 0
            
            if let window = UIApplication.shared.keyWindow {
                self.collectionView.frame = CGRect(x: 0, y: window.frame.height, width: self.collectionView.frame.width, height: self.collectionView.frame.height)
            }
            
        }) { (completed: Bool) in
            
            if setting.name != "Cancel" && setting.name != "" {
                self.homeController?.showSettingsController(setting: setting)
            }
        }

    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return settings.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! SettingsCell
        cell.setting = settings[indexPath.item]
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let setting = self.settings[indexPath.item]
        dismissMenu(setting: setting)
    }
}
