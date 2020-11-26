//
//  MemoComposeViewController.swift
//  SimpleMemo
//
//  Created by jaeyoung Yun on 2020/11/19.
//

import UIKit
import RxSwift
import RxCocoa
import Action
import NSObject_Rx

class MemoComposeViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoComposeViewModel!
    
    @IBOutlet weak var cancelButtonItem: UIBarButtonItem!
    @IBOutlet weak var saveButtonItem: UIBarButtonItem!
    @IBOutlet weak var contentTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.initialText
            .drive(contentTextView.rx.text)
            .disposed(by: rx.disposeBag)
        
        cancelButtonItem.rx.action = viewModel.cancelAction
        saveButtonItem.rx.tap
            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
            .withLatestFrom(contentTextView.rx.text.orEmpty)
            .bind(to: viewModel.saveAction.inputs)
            .disposed(by: rx.disposeBag)
        
        let keyboardWillShowObservable = NotificationCenter.default.rx.notification(UIResponder.keyboardWillShowNotification)
            .map { notification in
                (
                    (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as! CGRect).height,
                    notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
                )
            }

        let keyboardWillHideObservable = NotificationCenter.default.rx.notification(UIResponder.keyboardWillHideNotification)
            .map { notification in
                (
                    CGFloat(0),
                    notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as! TimeInterval
                )
            }
        
        Observable.merge(keyboardWillShowObservable, keyboardWillHideObservable)
            .share()
            .subscribe(onNext: { [weak self] height, duration in
                guard let strongSelf = self else { return }
                
                var inset = strongSelf.contentTextView.contentInset
                inset.bottom = height
                
                var scrollInset = strongSelf.contentTextView.verticalScrollIndicatorInsets
                scrollInset.bottom = height
                
                UIView.animate(withDuration: duration) {
                    strongSelf.contentTextView.contentInset = inset
                    strongSelf.contentTextView.verticalScrollIndicatorInsets = scrollInset
                    strongSelf.view.layoutIfNeeded()
                }
            })
            .disposed(by: rx.disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        contentTextView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if contentTextView.isFirstResponder {
            contentTextView.resignFirstResponder()
        }
    }
}
