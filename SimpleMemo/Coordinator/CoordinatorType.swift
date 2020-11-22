//
//  CoordinatorType.swift
//  SimpleMemo
//
//  Created by jaeyoung Yun on 2020/11/19.
//

import Foundation
import RxSwift

protocol CoordinatorType {
    
    func transition(to scene: Scene, using style: TransitionStyle, animated: Bool) -> Completable
    
    func close(animated: Bool) -> Completable
}
