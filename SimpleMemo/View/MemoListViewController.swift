//
//  MemoListViewController.swift
//  SimpleMemo
//
//  Created by jaeyoung Yun on 2020/11/19.
//

import UIKit

class MemoListViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }
    
    func bindViewModel() {
        
    }
}
