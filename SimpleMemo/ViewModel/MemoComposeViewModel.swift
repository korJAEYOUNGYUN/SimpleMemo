//
//  MemoComposeViewModel.swift
//  SimpleMemo
//
//  Created by jaeyoung Yun on 2020/11/19.
//

import Foundation
import RxSwift
import RxCocoa
import Action

class MemoComposeViewModel: BaseViewModel {
    
    private let content: String?
    
    var initialText: Driver<String?> {
        return Observable.just(content).asDriver(onErrorJustReturn: nil)
    }

    let saveAction: Action<String, Void>
    let cancelAction: CocoaAction
    
    init(title: String, content: String? = nil, coordinator: CoordinatorType, storage: MemoStorageType, saveAction: Action<String, Void>? = nil, cancelAction: CocoaAction? = nil) {
        self.content = content
        self.saveAction = Action { input in
            if let action = saveAction {
                action.execute(input)
            }
            
            return coordinator.close(animated: true).asObservable().map { _ in }
        }
        self.cancelAction = CocoaAction {
            if let action = cancelAction {
                action.execute()
            }
            
            return coordinator.close(animated: true).asObservable().map { _ in }
        }

        super.init(title: title, coordinator: coordinator, storage: storage)
    }
}
