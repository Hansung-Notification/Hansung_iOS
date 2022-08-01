//
//  RealmManager.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/08/01.
//

import Foundation

import RealmSwift

final class RealmManager {
    
    static let shared = RealmManager()
    
    private let localRealm = try! Realm()
    
    private init() {}
    
    func savePlaceListData(with list: FavoriteNoticeList) {
        try! localRealm.write {
            localRealm.add(list)
        }
    }
    
    func loadListData() -> Results<FavoriteNoticeList> {
        return localRealm.objects(FavoriteNoticeList.self)
        
    }
    
    func deleteListData(index: Int) {
        let task = localRealm.objects(FavoriteNoticeList.self)[index]
        try! localRealm.write {
            localRealm.delete(task)
        }
    }
    
    func deleteObjectData(object: FavoriteNoticeList) {
        try! localRealm.write {
            localRealm.delete(object)
        }
    }
}

