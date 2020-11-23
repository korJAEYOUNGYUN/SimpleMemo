//
//  BaseViewModel.swift
//  SimpleMemo
//
//  Created by jaeyoung Yun on 2020/11/22.
//

import Foundation
import RxSwift
import RxCocoa

class BaseViewModel {
    
    let title: Driver<String>
    let coordinator: CoordinatorType
    let storage: MemoStorageType
    
    init(title: String, coordinator: CoordinatorType, storage: MemoStorageType) {
        self.title = Observable.just(title).asDriver(onErrorJustReturn: "")
        self.coordinator = coordinator
        self.storage = storage
    }
}
