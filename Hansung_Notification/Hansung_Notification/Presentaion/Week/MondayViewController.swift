//
//  MondayViewController.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/08/01.
//

import UIKit
import SnapKit
import Then

class MondayViewController: UIViewController {
  
  private let dateLabel = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 15)
  }
  
  private let typeLabel1 = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 20)
  }
  
  private let menuLabel1 = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 15)
    $0.numberOfLines = 0
    $0.sizeToFit()
  }
  
  private let typeLabel2 = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 20)
  }
  
  private let menuLabel2 = UILabel().then {
    $0.font = UIFont.systemFont(ofSize: 15)
    $0.numberOfLines = 0
    $0.sizeToFit()
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    setupConstraints()
    CafeteriaCrawlManager.crawlCafeteria(vc: self)
  }

  func setupConstraints() {
    view.addSubview(dateLabel)
    dateLabel.snp.makeConstraints { make in
      make.top.equalToSuperview().offset(10)
      make.left.equalToSuperview().offset(10)
    }
    
    view.addSubview(typeLabel1)
    typeLabel1.snp.makeConstraints { make in
      make.top.equalTo(dateLabel.snp.bottom).offset(20)
      make.left.equalToSuperview().offset(10)
    }
    
    view.addSubview(menuLabel1)
    menuLabel1.snp.makeConstraints { make in
      make.top.equalTo(typeLabel1.snp.bottom).offset(20)
      make.left.equalToSuperview().offset(10)
      make.right.equalToSuperview().offset(-10)
    }
    
    view.addSubview(typeLabel2)
    typeLabel2.snp.makeConstraints { make in
      make.top.equalTo(menuLabel1.snp.bottom).offset(20)
      make.left.equalToSuperview().offset(10)
      make.right.equalToSuperview().offset(-10)
    }
    
    view.addSubview(menuLabel2)
    menuLabel2.snp.makeConstraints { make in
      make.top.equalTo(typeLabel2.snp.bottom).offset(20)
      make.left.equalToSuperview().offset(10)
      make.right.equalToSuperview().offset(-10)
    }
  }
  
  func setCafeteriaData() {
    dateLabel.text = CafeteriaCrawlManager.cafeteriaDayArray[0]
    typeLabel1.text = CafeteriaCrawlManager.cafeteriaTypeArray[0]
    menuLabel1.text = CafeteriaCrawlManager.cafeteriaMenuArray[0]
    typeLabel2.text = CafeteriaCrawlManager.cafeteriaTypeArray[1]
    menuLabel2.text = CafeteriaCrawlManager.cafeteriaMenuArray[1]
  }

}
extension MondayViewController: PageComponentProtocol {
    var pageTitle: String { "월" }
}


