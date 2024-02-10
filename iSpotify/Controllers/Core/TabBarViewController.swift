//
//  TabBarViewController.swift
//  iSpotify
//
//  Created by Ahmet Tarik DÖNER on 9.02.2024.
//

import UIKit

class TabBarViewController: UITabBarController {

    //MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
    }
    
    private func setupViewControllers() {
        let homeVC = HomeViewController()
        let searchVC = SearchViewController()
        let libraryVC = LibraryViewController()
        homeVC.navigationItem.largeTitleDisplayMode = .always
        searchVC.navigationItem.largeTitleDisplayMode = .always
        libraryVC.navigationItem.largeTitleDisplayMode = .always
        homeVC.title = "Browse"
        searchVC.title = "Search"
        libraryVC.title = "Library"
        
        let homeNavVC = UINavigationController(rootViewController: homeVC)
        let searchNavVC = UINavigationController(rootViewController: searchVC)
        let libraryNavVC = UINavigationController(rootViewController: libraryVC)
        homeNavVC.navigationBar.prefersLargeTitles = true
        searchNavVC.navigationBar.prefersLargeTitles = true
        libraryNavVC.navigationBar.prefersLargeTitles = true
        homeNavVC.navigationBar.tintColor = .label
        searchNavVC.navigationBar.tintColor = .label
        libraryNavVC.navigationBar.tintColor = .label
        
        homeNavVC.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), tag: 1)
        searchNavVC.tabBarItem = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), tag: 2)
        libraryNavVC.tabBarItem = UITabBarItem(title: "Library", image: UIImage(systemName: "music.note.list"), tag: 3)
        
        setViewControllers([homeNavVC, searchNavVC, libraryNavVC], animated: false)
    }
}
