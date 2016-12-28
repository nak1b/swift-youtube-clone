//
//  ViewController.swift
//  youtube
//
//  Created by Nakib on 12/10/16.
//  Copyright © 2016 Nakib. All rights reserved.
//

import UIKit

class HomeController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    let cellId = "cellId"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: view.frame.size.width-32, height: view.frame.size.height))
        titleLabel.text = "  Home"
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.systemFont(ofSize: 20)
        navigationItem.titleView = titleLabel
        
        setupCollectionView()
        setupNavBar()
        setupMenuBar()
    }
    
    func setupCollectionView() {
        
        if let layout = collectionView?.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 0
        }
        collectionView?.isPagingEnabled = true
        collectionView?.backgroundColor = UIColor.white;
        
        collectionView?.register(FeedCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
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
    
    func scrollToMenuAtIndex(index: Int) {
        let indexPath = IndexPath(item: index, section: 0)
        collectionView?.scrollToItem(at: indexPath, at: UICollectionViewScrollPosition(), animated: true)
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
    
    lazy var menuBar: MenuBar =  {
        let mb = MenuBar()
        mb.homeController = self
        mb.translatesAutoresizingMaskIntoConstraints = false
        
        return mb
    }()
    
    private func setupMenuBar() {
        navigationController?.hidesBarsOnSwipe = true
        
        let redView = UIView()
        redView.backgroundColor = UIColor.rgb(red: 230, green: 30, blue: 32)
        
        view.addSubview(redView)
        view.addConstraintsWithVisualFormat(format: "H:|[v0]|", views: redView)
        view.addConstraintsWithVisualFormat(format: "V:[v0(50)]", views: redView)
        
        view.addSubview(menuBar)
        view.addConstraintsWithVisualFormat(format: "H:|[v0]|", views: menuBar)
        view.addConstraintsWithVisualFormat(format: "V:[v0(50)]", views: menuBar)
        
        menuBar.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor).isActive = true
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: view.frame.size.width, height: view.frame.size.height - 50)
    }
    
    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        menuBar.barLeftAnchorConstraint?.constant = scrollView.contentOffset.x / 4
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.size.width
        let indexPath = IndexPath(item: Int(index), section: 0)
        
        menuBar.collectionView.selectItem(at: indexPath, animated: true, scrollPosition: UICollectionViewScrollPosition())
    }

}


