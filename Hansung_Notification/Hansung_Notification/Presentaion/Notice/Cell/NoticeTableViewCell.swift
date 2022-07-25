//
//  NoticeTableViewCell.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/07/26.
//

import UIKit

import SnapKit
import Then

final class NoticeTableViewCell: UITableViewCell, ViewPresentable {
    
    static let identifier: String = "NoticeTableViewCell"
    
    private lazy var titleLabel = UILabel().then {
        $0.text = "2023학년도 학석사연계과정 합격자 발표"
    }
    
    private lazy var dateLabel = UILabel().then {
        $0.text = "2022.06.24 대학원 교학팀"
    }
    
    private lazy var departmentLabel = UILabel().then {
        $0.text = ""
    }
    
    private lazy var starImage = UIImageView().then {
        $0.image = UIImage(systemName: "star")
        $0.tintColor = .gray
    }
    
    private lazy var verticalStackView = UIStackView().then {
        $0.alignment = .center
        $0.axis = .vertical
        $0.spacing = 5
    }
    
    private lazy var horizontalStackView = UIStackView().then {
        $0.alignment = .leading
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.spacing = 0
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
        [verticalStackView, horizontalStackView, starImage].forEach {
            addSubview($0)
        }
        
        [dateLabel, departmentLabel].forEach {
            horizontalStackView.addArrangedSubview($0)
        }
        
        [titleLabel, horizontalStackView].forEach {
            verticalStackView.addArrangedSubview($0)
        }
    }

    func setupConstraints() {
        verticalStackView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().inset(20)
            $0.trailing.equalTo(starImage.snp.leading).offset(-10)
        }
        
        horizontalStackView.snp.makeConstraints {
            $0.leading.equalTo(verticalStackView.snp.leading)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(verticalStackView.snp.leading)
        }
        
        starImage.snp.makeConstraints {
            $0.width.height.equalTo(30)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}
