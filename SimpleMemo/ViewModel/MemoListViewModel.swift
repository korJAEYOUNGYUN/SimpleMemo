//
//  MemoListViewModel.swift
//  SimpleMemo
//
//  Created by jaeyoung Yun on 2020/11/19.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoListViewModel: BaseViewModel {
    
    var memoList: Observable<[Memo]> {
        return storage.memoList()
    }
    
    func performUpdate(memo: Memo) -> Action<String, Void> {
        return Action { input in
            return self.storage.update(memo: memo, content: input).map { _ in }
        }
    }
    
    func performCancel(memo: Memo) -> CocoaAction {
        return Action {
            return self.storage.delete(memo: memo).map { _ in }
        }
    }
    
    func makeCreateAction() -> CocoaAction {
        return CocoaAction { _ in
            return self.storage.createMemo(content: "")
                .flatMap { (memo) -> Observable<Void> in
                    let composeViewModel = MemoComposeViewModel(title: "New Memo", coordinator: self.coordinator, storage: self.storage, saveAction: self.performUpdate(memo: memo), cancelAction: self.performCancel(memo: memo))
                    
                    let composeScene = Scene.compose(composeViewModel)
                    return self.coordinator.transition(to: composeScene, using: .modal, animated: true).asObservable().map { _ in }
                }
        }
    }
    
    lazy var detailAction: Action<Memo, Void> = {
        return Action { memo in
            let detailViewModel = MemoDetailViewModel(memo: memo, title: "memo detail", coordinator: self.coordinator, storage: self.storage)
            let detailScene = Scene.detail(detailViewModel)
            
            return self.coordinator.transition(to: detailScene, using: .push, animated: true).asObservable().map { _ in }
        }
    }()
}
