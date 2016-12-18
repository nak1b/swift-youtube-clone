//
//  ViewController.swift
//  youtube
//
//  Created by Nakib on 12/10/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    var videos:[Video] = {
        var mockingBird = Video()
        mockingBird.title = "Eminem - Mockingbird";
        mockingBird.thumbnailImageName = "eminem-mockingbird";
        
        var notAftraid = Video()
        notAftraid.title = "Eminem - Not Afraid";
        notAftraid.thumbnailImageName = "eminem-album-image";
        
        return [mockingBird, notAftraid]
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width-32, height: view.frame.size.height))
        titleLabel.text = "Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        collectionView?.backgroundColor = UIColor.white;
        
        collectionView?.register(VideoCell.self, forCellWithReuseIdentifier: "cellId")
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        
        setupNavBar()
        setupMenuBar()
    }
    
    private func setupNavBar() {
        navigationController?.navigationBar.isTranslucent = false
        let searchIcon = UIImage(named: "search_icon")?.withRenderingMode(.alwaysOriginal)
        let searchButton = UIBarButtonItem(image: searchIcon, style: .plain, target: self, action: #selector(handleSearch))
        
        let menuIcon = UIImage(named: "nav_more_icon")?.withRenderingMode(.alwaysOriginal)
        let menuButton = UIBarButtonItem(image: menuIcon, style: .plain, target: self, action: #selector(handleMenu))
        
        navigationItem.rightBarButtonItems = [menuButton, searchButton]
    }
    
    func handleSearch() {
        
    }
    
    func handleMenu() {
        
    }
    
    
    let menuBar: MenuBar =  {
        let mb = MenuBar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        
        return mb
    }()
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        
        view.addConstraintsWithVisualFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithVisualFormat(format: "V:|[v0(50)]|", views: menuBar)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // (frameWidth - paddingLeft - PaddingRight) * (9/16) + (PaddingTop + BottomContainer)
        let height = (self.view.frame.size.width - 16 - 16 ) * (9 / 16) + (16 + 68)
        return CGSize(width: self.view.frame.size.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}


