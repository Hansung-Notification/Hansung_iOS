//
//  ViewModelType.swift
//  Hansung_Notification
//
//  Created by 김승찬 on 2022/07/30.
//

import RxSwift

protocol ViewModelType {
    
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
