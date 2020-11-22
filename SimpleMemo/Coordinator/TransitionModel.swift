//
//  TransitionModel.swift
//  SimpleMemo
//
//  Created by jaeyoung Yun on 2020/11/19.
//

import Foundation

enum TransitionStyle {
    case root
    case push
    case modal
}

enum TransitionError: Error {
    case navigationControllerMissing
    case cannotPop
    case unknown
}
