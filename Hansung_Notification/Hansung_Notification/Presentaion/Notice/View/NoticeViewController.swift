//
//  NoticeViewController.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/07/25.
//

import UIKit

import RxSwift
import RxCocoa

protocol NoticeProtocol: DelegationProtocol, BindProtocol {}

final class NoticeViewController: UIViewController, NoticeProtocol {
    
    private let noticeView = NoticeView()
    
    private let disposeBag = DisposeBag()
    
    private let viewModel = NoticeViewModel()
    
    override func loadView() {
        self.view = noticeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getNoticeData()

        assignDelegation()
        bind()
    }
    
    func bind() {        
        viewModel.titleArray.bind { [weak self] _ in
            guard let self = self else { return }
            
            self.noticeView.tableView.reloadData()
        }
    }
    
    
    func assignDelegation() {
        noticeView.tableView.delegate = self
        noticeView.tableView.dataSource = self
    }
}

extension NoticeViewController: UITableViewDelegate {}

extension NoticeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.titleArray.value.count
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoticeTableViewCell.identifier, for: indexPath) as? NoticeTableViewCell else { return UITableViewCell() }
        
        cell.updateCell(viewModel, indexPath: indexPath)
 
        return cell
    }
}
