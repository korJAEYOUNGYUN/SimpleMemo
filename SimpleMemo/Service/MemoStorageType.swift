//
//  MemoStorageType.swift
//  SimpleMemo
//
//  Created by jaeyoung Yun on 2020/11/19.
//

import Foundation
import RxSwift

protocol MemoStorageType {
    
    func createMemo(content: String) -> Observable<Memo>
    
    func memoList() -> Observable<[Memo]>
    
    @discardableResult
    func update(memo: Memo, content: String) -> Observable<Memo>
    
    @discardableResult
    func delete(memo: Memo) -> Observable<Memo>
}
