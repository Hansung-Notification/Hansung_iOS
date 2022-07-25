//
//  NoticeViewController.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/07/25.
//

import UIKit

final class NoticeViewController: UIViewController {
    
    private let noticeView = NoticeView()
    
    override func loadView() {
        self.view = noticeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        assignDelegation()

    }
    
    private func assignDelegation() {
        noticeView.tableView.delegate = self
        noticeView.tableView.dataSource = self
    }
}

extension NoticeViewController: UITableViewDelegate {}

extension NoticeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoticeTableViewCell.identifier, for: indexPath) as? NoticeTableViewCell else { return UITableViewCell() }
        
        return cell
    }
}

