//
//  ThursdayViewController.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/08/01.
//

import UIKit

import SnapKit
import Then

class ThursdayViewController: UIViewController {

  var cafeteriaTableView = UITableView(frame: .zero, style: .grouped).then {
    $0.register(CafeteriaTableViewCell.self, forCellReuseIdentifier: CafeteriaTableViewCell.identifier)
    $0.estimatedRowHeight = 300
    $0.rowHeight = UITableView.automaticDimension
    $0.separatorStyle = .none
    $0.showsVerticalScrollIndicator = false
    $0.sectionFooterHeight = CGFloat.leastNormalMagnitude
    $0.backgroundColor = .white
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    initView()
    CafeteriaCrawlManager.crawlCafeteria(viewController: self)
  }
  
  func initView() {
    view.addSubview(cafeteriaTableView)
    cafeteriaTableView.snp.makeConstraints { make in
      make.trailing.leading.bottom.top.equalToSuperview()
    }
    cafeteriaTableView.delegate = self
    cafeteriaTableView.dataSource = self
  }
}

extension ThursdayViewController: UITableViewDelegate, UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 2
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell = cafeteriaTableView.dequeueReusableCell(withIdentifier: CafeteriaTableViewCell.identifier) as? CafeteriaTableViewCell else { return UITableViewCell() }
    if indexPath.row == 0 {
      cell.titleLabel.text = CafeteriaCrawlManager.cafeteriaTypeArray[6]
      cell.menuNameLabel.text = CafeteriaCrawlManager.cafeteriaMenuNameArray[6]
      cell.menuPriceLabel.text = CafeteriaCrawlManager.cafeteriaMenuPriceArray[6]
    }
    else {
      cell.titleLabel.text = CafeteriaCrawlManager.cafeteriaTypeArray[7]
      cell.menuNameLabel.text = CafeteriaCrawlManager.cafeteriaMenuNameArray[7]
      cell.menuPriceLabel.text = CafeteriaCrawlManager.cafeteriaMenuPriceArray[7]
    }
    cell.setAttributeString()
    return cell
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return CafeteriaCrawlManager.cafeteriaDayArray[3]
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 50
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let myLabel = UILabel().then {
      $0.frame = CGRect(x: 20, y: 20, width: 320, height: 20)
      $0.font = UIFont.systemFont(ofSize: 17, weight: .regular)
      $0.textColor = .darkGray
      $0.text = self.tableView(tableView, titleForHeaderInSection: section)
    }

    let headerView = UIView().then {
      $0.backgroundColor = .white
    }
    headerView.addSubview(myLabel)
    return headerView
  }
}


extension ThursdayViewController: PageComponentProtocol {
    var pageTitle: String { "목" }
}
