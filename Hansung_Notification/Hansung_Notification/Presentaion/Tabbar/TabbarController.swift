//
//  TabbarController.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/07/25.
//

import UIKit

final class TabBarController: UITabBarController {
    // MARK: - Properties
    
    private var tabs: [UIViewController] = []
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setTabBarAppearance()
        setTabBarItems()
//        navigationController?.navigationBar.isHidden = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let height: CGFloat = UIScreen.main.bounds.height / 9
        tabBar.frame.size.height = height
        tabBar.frame.origin.y = view.frame.height - height
        
    }

    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        guard let imageView = tabBar.subviews[item.tag + 1].subviews.compactMap({ $0 as? UIImageView }).first else { return }
        tabBarItemBounceAnimation(imageView: imageView)
    }
}

// MARK: - Functions

extension TabBarController {
    private func setTabBarAppearance() {
        
        UITabBar.appearance().shadowImage = nil
        UITabBar.appearance().backgroundImage = nil
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().tintColor = UIColor.black
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray

        tabBar.layer.borderWidth = 1.0
        tabBar.layer.borderColor = UIColor.white.cgColor
    }

    private func setTabBarItems() {
        tabs = [
            NoticeViewController(viewModel: NoticeViewModel()), CafeteriaViewController(), FavoriteViewController()
        ]

        TabBarItem.allCases.forEach {
            tabs[$0.rawValue].tabBarItem = $0.asTabBarItem()
            tabs[$0.rawValue].tabBarItem.tag = $0.rawValue
        }
        
        setViewControllers(tabs, animated: true)
    }
    
    private func tabBarItemBounceAnimation(imageView: UIImageView) {
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.5,
                       initialSpringVelocity: 0.5,
                       options: .curveEaseInOut) {
            
            imageView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.5,
                           initialSpringVelocity: 0.5,
                           options: .curveEaseInOut) {
                
                imageView.transform = CGAffineTransform(scaleX: 1, y: 1)
            }
        }
    }
}
