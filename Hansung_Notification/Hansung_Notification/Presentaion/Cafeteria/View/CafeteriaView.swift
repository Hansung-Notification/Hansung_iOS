//
//  CafeteriaView.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/07/25.
//

import UIKit

import SnapKit
import Then

final class CafeteriaView: UIView, ViewPresentable {
    
    let pagerTab = PagerTab()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func setupView() {
         addSubview(pagerTab)
    }
    
    func setupConstraints() {
        pagerTab.snp.makeConstraints {
            $0.top.equalToSuperview().inset(40)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }

}
