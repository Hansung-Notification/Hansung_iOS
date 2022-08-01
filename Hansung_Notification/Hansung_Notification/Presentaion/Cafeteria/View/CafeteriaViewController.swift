//
//  CafeteriaViewController.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/07/25.
//

import UIKit

final class CafeteriaViewController: UIViewController {
    
    private let cafeView = CafeteriaView()
    
    var viewControllers: [PageComponentProtocol] = [MondayViewController(), TuesdayViewController(), WednesViewController(), ThursdayViewController(), FridayViewController()]
    
    override func loadView() {
        self.view = cafeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setContainerViewController()

    }
    
}

extension CafeteriaViewController {
    private func setContainerViewController() {
        let style = PagerTab.Style.default
        cafeView.pagerTab.setup(self, viewControllers: viewControllers, style: style)
    }
}
