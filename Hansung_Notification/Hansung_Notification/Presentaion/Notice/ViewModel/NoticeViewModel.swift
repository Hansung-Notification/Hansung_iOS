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
    var urlArray: Helper<[String]> = Helper([])
    var dateArray: Helper<[String]> = Helper([])
    var isHeaderArray: Helper<[Bool]> = Helper([])
    var isNewArray: Helper<[Bool]> = Helper([])
    
    var noticeData: Helper<[NoticeData]> = Helper([])
 

    struct Input {
        let requestNoticeEvent: Signal<Void>
    }
    
    struct Output {
        let successNoticeModel: Observable<[NoticeData]>
    }
    
    let successNoticeModel = BehaviorRelay<[NoticeData]>(value: [])
    
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
        
        let noticeURL = URLs.baseURL + URLs.noticeURL
 
        AF.request(noticeURL).responseString { (response) in
                    guard let html = response.value else {
                        return
                    }
                    do {
                        let doc: Document = try SwiftSoup.parse(html)
                        
                        let docGetElementsTag = try doc.getElementsByTag("tbody").first!
                        
                        let useableDoc = try docGetElementsTag.getElementsByTag("tr")

                        let title: Elements = try useableDoc.select(".td-subject")
                        for element in title {
                            let titleData = try element.select("strong").text()
                            self.titleArray.value.append(titleData)
                        }
                        
    
                        let writer: Elements = try useableDoc.select(".td-write")
                
                        for element in writer {
                            let writeData = try element.select("td").text()
                            self.writerArray.value.append(writeData)
                        }
                        
                        let new: Elements = try useableDoc.select(".td-subject")
                        
                        for element in new {
                            let isNewData = try !element.select(".new").isEmpty()
                            self.isNewArray.value.append(isNewData)
                        }
                        
                        let num: Elements = try useableDoc.select(".td-num")
                        for element in num {
                            let numberData = try element.text()
                            let data: Bool = check(string: numberData)
                            self.isHeaderArray.value.append(data)
                        }
                        
                        func check(string: String) -> Bool {
                            if string.contains("8") || string.contains("9") || string.contains("0") {
                                return false
                            } else {
                                return true
                            }
                        }
                        
                        let date: Elements = try useableDoc.select(".td-date")
                        for element in date {
                            let dateData = try element.select("td").text()
                            self.dateArray.value.append(dateData)
                        }
                        
                        let url: Elements = try useableDoc.select("a[href]")
                        for element in url {
                            let urlData = try element.attr("href")
                            self.urlArray.value.append(urlData)
                        }
                        
                        for ((((titleData, urlData), (writerData, dateData)), isNewData), isHeaderData) in zip(zip(
                            zip(zip(self.titleArray.value, self.urlArray.value), zip(self.writerArray.value, self.dateArray.value)), self.isNewArray.value), self.isHeaderArray.value) {
                            let data = NoticeData(isHeader: isHeaderData, isNew: isNewData, title: titleData, date: dateData, writer: writerData, url: urlData)
                            
                            self.noticeData.value.append(data)
                        }
                        
                        dump(self.noticeData.value)
                    } catch {
                        print("crawl error")
            }
        }
    }
}

