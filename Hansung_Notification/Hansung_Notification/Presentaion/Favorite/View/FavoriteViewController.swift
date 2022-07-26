//
//  FavoriteViewController.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/07/25.
//

import UIKit

protocol FavoriteProtocol: DelegationProtocol {}

final class FavoriteViewController: UIViewController, FavoriteProtocol {
    
    private let favoriteView = FavoriteView()
    
    override func loadView() {
        self.view = favoriteView
    }
  
    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegation()
    }
    
    func assignDelegation() {
        favoriteView.tableView.delegate = self
        favoriteView.tableView.dataSource = self
    }
    
}

extension FavoriteViewController: UITableViewDelegate {}

extension FavoriteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoticeTableViewCell.identifier, for: indexPath) as? NoticeTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}

