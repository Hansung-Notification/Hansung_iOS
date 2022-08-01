//
//  FavoriteNoticeList.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/08/01.
//

import Foundation

import RealmSwift

final class FavoriteNoticeList: Object {

    @Persisted var title: String
    @Persisted var date: String
    @Persisted var writer: String
    @Persisted var url: String
    @Persisted var isFavorite: Bool

    @Persisted(primaryKey: true) var _id: ObjectId

    convenience init(title: String, date: String, writer: String, url: String, isFavorite: Bool) {
        self.init()

        self.title = title
        self.date = date
        self.writer = writer
        self.url = url
        self.isFavorite = false
    }
}
