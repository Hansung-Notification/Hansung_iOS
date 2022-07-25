//
//  TabbarItem.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/07/25.
//

import UIKit

enum TabBarItem: Int, CaseIterable {
    case notice
    case cafeteria
    case favorite
}

extension TabBarItem {
    var title: String {
        switch self {
        case .notice:         return "공지사항"
        case .cafeteria:      return "학생식당"
        case .favorite:     return "즐겨찾기"
        }
    }
}

extension TabBarItem {
    var inactiveIcon: UIImage? {
        switch self {
        case .notice:         return UIImage(systemName: "house")!
        case .cafeteria:        return UIImage(systemName: "fork.knife")!
        case .favorite:     return UIImage(systemName: "heart.fill")!
        }
    }
    
    var activeIcon: UIImage? {
        switch self {
        case .notice:         return UIImage(systemName: "house")!
        case .cafeteria:        return UIImage(systemName: "fork.knife")!
        case .favorite:     return UIImage(systemName: "heart.fill")!
        }
    }
}

extension TabBarItem {
    public func asTabBarItem() -> UITabBarItem {
        return UITabBarItem(
            title: title,
            image: inactiveIcon,
            selectedImage: activeIcon
        )
    }
}
