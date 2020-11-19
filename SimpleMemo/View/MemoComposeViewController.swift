//
//  MemoComposeViewController.swift
//  SimpleMemo
//
//  Created by jaeyoung Yun on 2020/11/19.
//

import UIKit

class MemoComposeViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoComposeViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }
    
    func bindViewModel() {
    }
}
