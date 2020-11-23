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
    
    func performUpdate(memo: Memo) -> Action<String, Void> {
        return Action { input in
            self.storage.update(memo: memo, content: input)
                .subscribe(onNext: { updated in
                    self.contents.onNext([updated.content, self.formatter.string(from: updated.createdAt)])
                })
                .disposed(by: self.rx.disposeBag)
            
            return Observable.empty()
        }
    }
    
    func makeEditAction() -> CocoaAction {
        return CocoaAction {
            let composeViewModel = MemoComposeViewModel(title: "Edit Memo", content: self.memo.content, coordinator: self.coordinator, storage: self.storage, saveAction: self.performUpdate(memo: self.memo))
            
            let composeScene = Scene.compose(composeViewModel)
            
            return self.coordinator.transition(to: composeScene, using: .modal, animated: true).asObservable().map { _ in }
        }
    }
}
