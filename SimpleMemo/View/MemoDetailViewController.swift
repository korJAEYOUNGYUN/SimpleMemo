//
//  MemoDetailViewController.swift
//  SimpleMemo
//
//  Created by jaeyoung Yun on 2020/11/19.
//

import UIKit
import RxSwift
import RxCocoa
import Action

class MemoDetailViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoDetailViewModel!
    
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var deleteButtonItem: UIBarButtonItem!
    @IBOutlet weak var updateButtonItem: UIBarButtonItem!
    @IBOutlet weak var shareButtonItem: UIBarButtonItem!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func bindViewModel() {
        viewModel.title
            .drive(navigationItem.rx.title)
            .disposed(by: rx.disposeBag)
        
        viewModel.contents
            .bind(to: listTableView.rx.items) { tableView, row, value in
                switch row {
                case 0:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "contentCell")!
                    cell.textLabel?.text = value
                    return cell
                case 1:
                    let cell = tableView.dequeueReusableCell(withIdentifier: "dateCell")!
                    cell.textLabel?.text = value
                    return cell
                default:
                    fatalError()
                }
            }
            .disposed(by: rx.disposeBag)
        
        updateButtonItem.rx.action = viewModel.makeEditAction()
        
//        shareButtonItem.rx.tap
//            .throttle(.milliseconds(500), scheduler: MainScheduler.instance)
//            .subscribe(onNext: { [unowned self] _ in
//                let vc = UIActivityViewController(activityItems: [self.viewModel.memo.content], applicationActivities: nil)
//                self.present(vc, animated: true, completion: nil)
//            })
//            .disposed(by: rx.disposeBag)
        shareButtonItem.rx.action = CocoaAction { [unowned self] in
            let vc = UIActivityViewController(activityItems: [self.viewModel.memo.content], applicationActivities: nil)
            self.present(vc, animated: true, completion: nil)
            
            return Observable.empty()
        }
    }
}
