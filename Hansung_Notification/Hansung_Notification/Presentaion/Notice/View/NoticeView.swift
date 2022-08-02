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
    
    lazy var navigationTitle = UILabel().then {
        $0.text = "공지사항"
        $0.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    lazy var searchButton = UIButton().then {
        $0.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        $0.tintColor = .black
    }
    
    private lazy var keywordButton = UIButton().then {
        $0.setImage(UIImage(systemName: "list.bullet"), for: .normal)
        $0.tintColor = .black
    }

    lazy var verticalStackView = UIStackView().then {
        $0.axis = .vertical
    }
    
    lazy var searchBar = UISearchBar()
    
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
        [searchBar, tableView].forEach {
            verticalStackView.addArrangedSubview($0)
        }
        
        [navigationTitle, keywordButton, searchButton, verticalStackView].forEach {
            addSubview($0)
        }
    }
    
    func setupConstraints() {
    
        navigationTitle.snp.makeConstraints {
            $0.top.equalToSuperview().inset(50)
            $0.leading.equalToSuperview().inset(20)
        }
        
        verticalStackView.snp.makeConstraints {
            $0.top.equalTo(navigationTitle.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.centerY.equalTo(navigationTitle.snp.centerY)
            $0.trailing.equalTo(keywordButton.snp.leading).inset(-10)
        }
        
        keywordButton.snp.makeConstraints {
            $0.width.height.equalTo(40)
            $0.centerY.equalTo(navigationTitle.snp.centerY)
            $0.trailing.equalToSuperview().inset(10)
        }
        
     
    }

}
