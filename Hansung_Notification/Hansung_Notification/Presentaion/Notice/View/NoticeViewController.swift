//
//  NoticeViewController.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/07/25.
//

import UIKit

import RxSwift
import RxCocoa

protocol NoticeProtocol: BindProtocol {}

final class NoticeViewController: UIViewController, NoticeProtocol {
    
    private let noticeView = NoticeView()
    private var viewModel: NoticeViewModel
    
    private let disposeBag = DisposeBag()
    
    private lazy var input = NoticeViewModel.Input(requestNoticeEvent: requestNoticeData.asSignal())
    
    private let requestNoticeData = PublishRelay<Void>()
    
    private lazy var output = viewModel.transform(input: input)
    init(viewModel: NoticeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = noticeView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.requestNoticeData.accept(())
    }
    
    func bind() {
        output.successNoticeModel.drive(noticeView.tableView.rx.items(cellIdentifier: NoticeTableViewCell.identifier, cellType: NoticeTableViewCell.self)) {
            (row, element, cell) in
            cell.updateCell(notice: element)
        }.disposed(by: disposeBag)
        
        noticeView.tableView.rx.itemSelected
            .bind { [weak self] indexPath in
                guard let self = self else { return }
                self.presentWebView()
            }.disposed(by: disposeBag)
        
        noticeView.searchButton.rx.tap.bind {
            self.noticeView.searchBar.isHidden = true
        }.disposed(by: disposeBag)
    }
}

extension NoticeViewController {
    private func presentWebView() {
        let webView = WebKitViewController()
        self.present(webView, animated: true)
    }
}
