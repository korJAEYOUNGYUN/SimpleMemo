//
//  Memo.swift
//  SimpleMemo
//
//  Created by jaeyoung Yun on 2020/11/19.
//

import Foundation
import RxDataSources

struct Memo: Equatable, IdentifiableType {
    
    var content: String
    var createdAt: Date
    var identity: String
    
    init(content: String, createdAt: Date = Date()) {
        self.content = content
        self.createdAt = createdAt
        self.identity = UUID().uuidString
    }
    
    init(original: Memo, updatedContent: String) {
        self = original
        self.content = updatedContent
    }
}
