//
//  NoticeView.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/07/25.
//

import UIKit

import SnapKit
import Then

final class NoticeView: UIView, ViewPresentable {
    
    lazy var tableView = UITableView().then {
        $0.register(NoticeTableViewCell.self, forCellReuseIdentifier: NoticeTableViewCell.identifier)
        $0.rowHeight = 100
        $0.separatorInset.left = 15
        $0.separatorInset.right = 15
    }
    
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
         addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.top.equalTo(safeAreaInsets)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(safeAreaLayoutGuide)
        }
    }

}
