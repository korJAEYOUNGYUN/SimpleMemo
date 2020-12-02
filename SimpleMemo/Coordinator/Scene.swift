//
//  Scene.swift
//  SimpleMemo
//
//  Created by jaeyoung Yun on 2020/11/19.
//

import UIKit

enum Scene {
    
    case list(MemoListViewModel)
    case detail(MemoDetailViewModel)
    case compose(MemoComposeViewModel)
}

extension Scene {
    
    func instantiate() -> UIViewController {
        switch self {
        case .list(let viewModel):
            let storyboard = UIStoryboard(name: "MemoListViewController", bundle: nil)

            guard let nav = storyboard.instantiateViewController(withIdentifier: "ListNav") as? UINavigationController else {
                fatalError()
            }
            
            guard var listVC = nav.viewControllers.first as? MemoListViewController else {
                fatalError()
            }
            
            listVC.bind(viewModel: viewModel)
            return nav
            
        case .detail(let viewModel):
            let storyboard = UIStoryboard(name: "MemoDetailViewController", bundle: nil)

            guard var detailVC = storyboard.instantiateViewController(withIdentifier: "DetailVC") as? MemoDetailViewController else {
                fatalError()
            }
            
            detailVC.bind(viewModel: viewModel)
            return detailVC
        
        case .compose(let viewModel):
            let storyboard = UIStoryboard(name: "MemoComposeViewController", bundle: nil)

            guard let nav = storyboard.instantiateViewController(withIdentifier: "ComposeNav") as? UINavigationController else {
                fatalError()
            }
            
            guard var composeVC = nav.viewControllers.first as? MemoComposeViewController else {
                fatalError()
            }
            
            composeVC.bind(viewModel: viewModel)
            return nav
        }
    }
}
