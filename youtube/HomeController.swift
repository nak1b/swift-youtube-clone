//
//  ViewController.swift
//  youtube
//
//  Created by Nakib on 12/10/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    var videos:[Video]?
    
    func fetchVideos() {
        let url = URL(string: "https://s3-us-west-2.amazonaws.com/youtubeassets/home.json")
        URLSession.shared.dataTask(with: url!, completionHandler: {(data, response, error) in
            if error != nil {
                print(error!)
                return
            }
            
            do {
               let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers)
                self.videos = [Video]()
                
                for dictionary in json as! [[String:AnyObject]] {
                    let video = Video()
                    video.title = dictionary["title"] as? String
                    video.thumbnailImageName = dictionary["thumbnail_image_name"] as? String
                    
                    let channelDict = dictionary["channel"] as! [String:AnyObject]
                    
                    let channel = Channel()
                    channel.profileImage = channelDict["profile_image_name"] as? String
                    channel.name = channelDict["name"] as? String
            
                    video.channel = channel
                    
                    self.videos?.append(video)
                }
                
                DispatchQueue.main.async {
                    self.collectionView?.reloadData()
                }
        
                
            } catch let jsonErr {
                print(jsonErr)
            }
            
        }).resume()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchVideos()
        
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
    
    lazy var settingsMenu: SettingsMenu = {
        let menu = SettingsMenu()
        menu.homeController = self
        
        return menu
    }()

    
    func handleMenu() {
        settingsMenu.openMenu()
    }
    
    func showSettingsController(setting: Setting) {
        let dummyViewController = UIViewController()
        dummyViewController.view.backgroundColor = UIColor.white
        dummyViewController.navigationItem.title = setting.name.rawValue
        navigationController?.navigationBar.tintColor = UIColor.white
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.white]
        navigationController?.pushViewController(dummyViewController, animated: true)
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

        return videos?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! VideoCell
        cell.video = videos?[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        // (frameWidth - paddingLeft - PaddingRight) * (9/16) + (PaddingTop + BottomContainer)
        let height = (self.view.frame.size.width - 16 - 16 ) * (9 / 16) + (16 + 88)
        return CGSize(width: self.view.frame.size.width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }

}


