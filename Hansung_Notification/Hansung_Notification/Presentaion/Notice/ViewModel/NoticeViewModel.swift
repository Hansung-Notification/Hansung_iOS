//
//  NoticeViewModel.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/07/25.
//

import Foundation

import RxSwift
import RxCocoa
import Alamofire
import SwiftSoup
import SwiftUI

final class NoticeViewModel: ViewModelType {
    
    
    var disposeBag = DisposeBag()
    
    var titleArray: Helper<[String]> = Helper([])
    var writerArray: Helper<[String]> = Helper([])
    var urlArray: [String] = []
    var dateArray: Helper<[String]> = Helper([])
    var isHeaderArray: [Bool] = []
    var isNewArray: [Bool] = []
    
    var noticeData: Helper<[Notice]> = Helper([])
 

    struct Input {
        let requestNoticeEvent: Signal<Void>
    }
    
    struct Output {
        let successNoticeModel: Observable<[Notice]>
    }
    
    let successNoticeModel = BehaviorRelay<[Notice]>(value: [])
    
    func transform(input: Input) -> Output {
        input.requestNoticeEvent.emit { [weak self] _ in
            guard let self = self else { return }
            self.successNoticeModel.accept(self.noticeData.value)
            
        }.disposed(by: disposeBag)
        
        return Output(successNoticeModel: successNoticeModel.asObservable())
    }
    
   
}

extension NoticeViewModel {
    func getNoticeData() {
        
        let baseURL = URLs.baseURL
 
        AF.request(baseURL).responseString { (response) in
                    guard let html = response.value else {
                        return
                    }
                    do {
                        let doc: Document = try SwiftSoup.parse(html)

                        let title: Elements = try doc.select(".td-subject")
                        for element in title {
                            let titleData = try element.select("strong").text()
                            self.titleArray.value.append(titleData)
                        }

                        let writer: Elements = try doc.select(".td-write")
                
                        for element in writer {
                            let writeData = try element.select("td").text()
                            self.writerArray.value.append(writeData)
                        }

                        let date: Elements = try doc.select(".td-date")
                        for element in date {
                            let dateData = try element.select("td").text()
                            self.dateArray.value.append(dateData)
                            
                        }
                        
                        let new: Elements = try doc.select(".new")
                        for element in new {
                            let newData = try element.empty()

                        }
                        
                    } catch {
                        print("crawl error")
                    }
                }
    }
}
