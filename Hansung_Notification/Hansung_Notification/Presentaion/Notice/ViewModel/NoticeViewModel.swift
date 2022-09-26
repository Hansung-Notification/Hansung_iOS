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

final class NoticeViewModel: ViewModelType {
    
    struct Input {
        let requestNoticeEvent: Signal<Void>
    }
    
    struct Output {
        let successNoticeModel: Driver<[NoticeData]>
    }
    
    private let successNoticeModel = BehaviorRelay<[NoticeData]>(value: [])
    
    var disposeBag = DisposeBag()
    private var titleArray: Helper<[String]> = Helper([])
    private var writerArray: Helper<[String]> = Helper([])
    private var urlArray: Helper<[String]> = Helper([])
    private var dateArray: Helper<[String]> = Helper([])
    private var isHeaderArray: Helper<[Bool]> = Helper([])
    private var isNewArray: Helper<[Bool]> = Helper([])
    private var noticeData: Helper<[NoticeData]> = Helper([])

    func transform(input: Input) -> Output {
        input.requestNoticeEvent.emit { [weak self] _ in
            guard let self = self else { return }
            self.getNoticeData()
        }
        .disposed(by: disposeBag)
        
        return Output(successNoticeModel: successNoticeModel.asDriver())
    }
}

extension NoticeViewModel {
    private func getNoticeData() {
        
        let noticeURL = URLs.baseURL + URLs.noticeURL + "?page=\(3)"

        AF.request(noticeURL).responseString { (response) in
                    guard let html = response.value else {
                        return
                    }
                    do {
                        let doc: Document = try SwiftSoup.parse(html)
                        
                        let docGetElementsTag = try doc.getElementsByTag("tbody").first!
                        
                        let useableDoc = try docGetElementsTag.getElementsByTag("tr")
                        
                        //print(doc)

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
                            self.successNoticeModel.accept(self.noticeData.value)
                        }
                    } catch {
                        print("crawl error")
            }
        }
    }
    
    func searchNotice(query: String) {
        
    }
}

