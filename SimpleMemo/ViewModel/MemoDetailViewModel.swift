//
//  MemoDetailViewModel.swift
//  SimpleMemo
//
//  Created by jaeyoung Yun on 2020/11/19.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoDetailViewModel: BaseViewModel {
    
    let memo: Memo
    private var formatter: DateFormatter = {
        let f = DateFormatter()
        f.locale = Locale(identifier: "Ko_kr")
        f.dateStyle = .medium
        f.timeStyle = .medium
        return f
    }()
    
    var contents: BehaviorSubject<[String]>
    
    init(memo: Memo, title: String, coordinator: CoordinatorType, storage: MemoStorageType) {
        self.memo = memo
        contents = BehaviorSubject(value: [memo.content, formatter.string(from: memo.createdAt)])
        
        super.init(title: title, coordinator: coordinator, storage: storage)
    }
}
