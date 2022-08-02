//
//  NoticeTableViewCell.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/07/26.
//

import UIKit

import SnapKit
import Then

protocol FavoriteButtonProtocol: AnyObject {
    func didTapFavoriteButton(tag: Int)
}

final class NoticeTableViewCell: UITableViewCell, ViewPresentable {
    
    weak var delegate: FavoriteButtonProtocol?
    
    static let identifier: String = "NoticeTableViewCell"
    
    lazy var titleLabel = UILabel().then {
        $0.text = "2023학년도 학석사연계과정 합격자 발표"
    }
    
    private lazy var dateLabel = UILabel().then {
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .systemGray
    }
    
    private lazy var writerLabel = UILabel().then {
        $0.font = UIFont.italicSystemFont(ofSize: 15)
        $0.textColor = .systemGray
    }
    
    private lazy var newLabel = UILabel().then {
        $0.text = "new!"
        $0.font = UIFont.systemFont(ofSize: 15)
        $0.textColor = .systemGray
    }
    
    private lazy var favoriteButton = UIButton().then {
        $0.setImage(UIImage(systemName: "star"), for: .normal)
        $0.tintColor = .gray
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
        setupConstraints()
    }

    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        favoriteButton.addTarget(self, action: #selector(favoriteButtonTapped(sender:)), for: .touchUpInside)
        
        [dateLabel, newLabel, writerLabel, favoriteButton, titleLabel].forEach {
            contentView.addSubview($0)
        }
    }

    func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().inset(30)
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(favoriteButton.snp.leading).inset(10)
        }
        
        dateLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(titleLabel.snp.leading)
        }
        
        writerLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(dateLabel.snp.trailing).offset(3)
        }
        
        newLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(5)
            $0.leading.equalTo(writerLabel.snp.trailing).offset(3)
        }
        
        favoriteButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(40)
            $0.trailing.equalToSuperview().inset(10)
        }
    }
    
    func updateCell(notice: NoticeData) {
        titleLabel.text = notice.title
        writerLabel.text = notice.writer
        dateLabel.text = notice.date
    
        // 코드 리팩토링
        if notice.isNew {
            newLabel.isHidden = false
        } else {
            newLabel.isHidden = true
        }
        
        if notice.isHeader {
            contentView.backgroundColor = .red
        } else {
            contentView.backgroundColor = .white
        }
    }
    
    @objc func favoriteButtonTapped(sender: UIButton) {
        self.delegate?.didTapFavoriteButton(tag: sender.tag)
    }
}
