//
//  MemoDetailViewController.swift
//  SimpleMemo
//
//  Created by jaeyoung Yun on 2020/11/19.
//

import UIKit

class MemoDetailViewController: UIViewController, ViewModelBindableType {

    var viewModel: MemoDetailViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindViewModel()
    }
    
    func bindViewModel() {
        <#code#>
    }
}
