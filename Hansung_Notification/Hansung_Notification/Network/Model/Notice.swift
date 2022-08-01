//
//  Notice.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/07/26.
//

import Foundation

struct Notice {
    
    var notice: [NoticeModel]
    
}

struct NoticeData {
    var isHeader: Bool
    var isNew: Bool
    var title: String
    var date: String
    var writer: String
    var url: String
}

struct NoticeModel {
    var isHeader: Bool
    var isNew: Bool
    var title: String
    var date: String
    var writer: String
    var url: String
}



