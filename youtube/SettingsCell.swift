//
//  SettingsCell.swift
//  youtube
//
//  Created by Nakib on 12/24/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import UIKit

class SettingsCell: BaseCell {
    
    override var isHighlighted: Bool {
        didSet {
            backgroundColor = isHighlighted ? UIColor.darkGray : UIColor.white
            nameLabel.textColor = isHighlighted ? UIColor.white : UIColor.darkGray
            iconImage.tintColor = isHighlighted ? UIColor.white : UIColor.darkGray
        }
    }
    
    var setting:Setting? {
        didSet {
            nameLabel.text = setting?.name.rawValue
            
            if let imageName = setting?.iconName {
                iconImage.image = UIImage(named: imageName)?.withRenderingMode(.alwaysTemplate)
                iconImage.tintColor = UIColor.darkGray
            }
        }
    }
    
    let nameLabel:UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = UIFont.systemFont(ofSize: 13)
        
        return label
    }()
    
    let iconImage:UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "settings")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
 
    override func setupView() {
        super.setupView()
        
        addSubview(nameLabel)
        addSubview(iconImage)
        
        addConstraintsWithVisualFormat(format: "H:|-8-[v0(30)]-8-[v1]|", views: iconImage, nameLabel)
        addConstraintsWithVisualFormat(format: "V:|[v0]|", views: nameLabel)
        addConstraintsWithVisualFormat(format: "V:[v0(30)]", views: iconImage)
        
        addConstraint(NSLayoutConstraint(item: iconImage, attribute: .centerY, relatedBy: .equal, toItem: self, attribute: .centerY, multiplier: 1, constant: 0))
        
    }
}
