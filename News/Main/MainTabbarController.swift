//
//  MainTabbarController.swift
//  News
//
//  Created by Maul on 19/02/22.
//


import UIKit

class MainTabbarController: UITabBarController {
    /// Index VC
    var tabSelected = 0
    private var tabHome = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        delegate = self
        tabBar.isTranslucent = false
        tabBar.barTintColor = .white
        
        viewControllers = [
            setTabbarItem(vc: HomeView(), title: "Home", img: .homeIcon, imgSelected: .homeIconSelected),
            setTabbarItem(vc: ProfileView(), title: "Profile", img: .profileIcon, imgSelected: .profileIconSelected)
        ]
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        /// remove title on back button
        navigationItem.title = " "
    }
    
    private func setTabbarItem(vc: UIViewController, title: String, img: UIImage?, imgSelected: UIImage?) -> UIViewController {
        let nav = vc
        nav.tabBarItem.title = title
        nav.tabBarItem.imageInsets = UIEdgeInsets(top: 4, left: 0, bottom: 0, right: 0)
        nav.tabBarItem.image = img?.withRenderingMode(.alwaysOriginal)
        nav.tabBarItem.selectedImage = imgSelected?.withRenderingMode(.alwaysOriginal)
        
        return nav
    }
}

extension MainTabbarController: UITabBarControllerDelegate
{
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if let items = tabBar.items {
            items.enumerated().forEach { if $1 == item { updateIndicator($0) } }
        }
    }
    
    private func updateIndicator(_ i: Int) {
        /// Home is active and pressed again
        if i == tabHome, i == tabSelected {
            selectedAgain()
        }
        
        tabSelected = i
    }
    
    private func selectedAgain() {
        switch tabSelected {
        case tabHome:
            if let home = viewControllers?[tabSelected] as? HomeView {
                home.scrollToTop()
            }
        default:
            return
        }
    }
}
