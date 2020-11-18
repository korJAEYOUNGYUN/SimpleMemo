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
    
    private lazy var store = BehaviorSubject<[Memo]>(value: list)

    func createMemo(content: String) -> Observable<Memo> {
        let memo = Memo(content: content)
        list.insert(memo, at: 0)
        
        store.onNext(list)
        
        return Observable.just(memo)
    }
    
    func memoList() -> Observable<[Memo]> {
        return store
    }
    
    func update(memo: Memo, content: String) -> Observable<Memo> {
        let updated = Memo(original: memo, updatedContent: content)
        
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
            list.insert(updated, at: index)
        }
        
        store.onNext(list)
        
        return Observable.just(updated)
    }
    
    func delete(memo: Memo) -> Observable<Memo> {
        if let index = list.firstIndex(where: { $0 == memo }) {
            list.remove(at: index)
        }
        
        store.onNext(list)
        
        return Observable.just(memo)
    }
}
