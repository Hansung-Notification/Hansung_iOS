//
//  NetworkResult.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/07/30.
//

import Foundation

enum NetworkResult<T> {
    case success(T)
    case requestErr(T)
    case pathErr
    case serverErr
    case networkFail
}
