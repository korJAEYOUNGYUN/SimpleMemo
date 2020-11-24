//
//  MemoryStorage.swift
//  SimpleMemo
//
//  Created by jaeyoung Yun on 2020/11/19.
//

import Foundation
import RxSwift

class MemoryStorage: MemoStorageType {
    
    private var list = [
        Memo(content: "Hello, RxSwift", createdAt: Date().addingTimeInterval(-10)),
        Memo(content: "Hello, there", createdAt: Date().addingTimeInterval(-20)),
        Memo(content: "aaa", createdAt: Date().addingTimeInterval(-30)),
        Memo(content: "doing something", createdAt: Date().addingTimeInterval(-40)),
    ]
    
    private lazy var sectionModel = MemoSectionModel(model: 0, items: list)
    
    private lazy var store = BehaviorSubject<[MemoSectionModel]>(value: [sectionModel])

    func createMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content: content)
        sectionModel.items.insert(memo, at: 0)
        
        store.onNext([sectionModel])
        
        return Observable.just(memo)
    }
    
    func memoList() -> Observable<[MemoSectionModel]> {
        return store
    }
    
    func update(memo: Memo, content: String) -> Observable<Memo> {
        let updated = Memo(original: memo, updatedContent: content)
        
        if let index = sectionModel.items.firstIndex(where: { $0 == memo }) {
            sectionModel.items.remove(at: index)
            sectionModel.items.insert(updated, at: index)
        }
        
        store.onNext([sectionModel])
        
        return Observable.just(updated)
    }
    
    func delete(memo: Memo) -> Observable<Memo> {
        if let index = sectionModel.items.firstIndex(where: { $0 == memo }) {
            sectionModel.items.remove(at: index)
        }
        
        store.onNext([sectionModel])
        
        return Observable.just(memo)
    }
}
