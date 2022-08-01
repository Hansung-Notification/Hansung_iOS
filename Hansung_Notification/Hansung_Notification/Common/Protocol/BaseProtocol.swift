//
//  BaseProtocol.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/07/26.
//

import Foundation

protocol DelegationProtocol {
    func assignDelegation()
}

protocol TargetProtocol {
    func addTarget()
}

protocol BindProtocol {
    func bind()
}
