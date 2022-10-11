//
//  CafeteriaTableViewCell.swift
//  Hansung_Notification
//
//  Created by 임영선 on 2022/10/11.
//

import UIKit

import SnapKit
import Then

class CafeteriaTableViewCell: UITableViewCell {
  
  static let identifier: String = "CafeteriaTableViewCell"
  
  private var cellView = UIView().then {
    $0.backgroundColor = UIColor(named: "backgroundColor")
    $0.layer.cornerRadius = 15
  }
  
  var titleLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 23, weight: .regular)
  }
  
  var menuNameLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 16, weight: .light)
    $0.textAlignment = .left
    $0.numberOfLines = 0
  }
  
  var menuPriceLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 16)
    $0.textColor = .darkGray
    $0.textAlignment = .right
    $0.numberOfLines = 0
  }
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupConstraints()
    self.selectionStyle = .none
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func setupConstraints() {
    [cellView, titleLabel, menuNameLabel, menuPriceLabel].forEach {
      contentView.addSubview($0)
    }
    cellView.snp.makeConstraints { make in
      make.leading.top.equalToSuperview().offset(15)
      make.trailing.bottom.equalToSuperview().offset(-15)
    }
    
    titleLabel.snp.makeConstraints { make in
      make.top.leading.equalTo(cellView).offset(20)
    }
    
    menuNameLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(15)
      make.leading.equalTo(cellView).offset(20)
      make.bottom.equalTo(cellView).offset(-15)
    }
    
    menuPriceLabel.snp.makeConstraints { make in
      make.top.equalTo(titleLabel.snp.bottom).offset(15)
      make.trailing.equalTo(cellView).offset(-20)
      make.bottom.equalTo(cellView).offset(-15)
    }
  }
  
  func setAttributeString() {
    if let text = menuNameLabel.text {
      let attrString1 = NSMutableAttributedString(string: text)
      let paragraphStyle1 = NSMutableParagraphStyle()
      paragraphStyle1.lineSpacing = 8
      attrString1.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle1, range: NSMakeRange(0, attrString1.length))
      menuNameLabel.attributedText = attrString1
    }
    
    if let text = menuPriceLabel.text {
      let attrString2 = NSMutableAttributedString(string: text)
      let paragraphStyle2 = NSMutableParagraphStyle()
      paragraphStyle2.lineSpacing = 8
      attrString2.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle2, range: NSMakeRange(0, attrString2.length))
      menuPriceLabel.attributedText = attrString2
    }
  }
}



