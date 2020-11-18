//
//  Memo.swift
//  SimpleMemo
//
//  Created by jaeyoung Yun on 2020/11/19.
//

import Foundation

struct Memo: Equatable {
    
    var content: String
    var createdAt: Date
    var id: String
    
    init(content: String, createdAt: Date = Date()) {
        self.content = content
        self.createdAt = createdAt
        self.id = UUID().uuidString
    }
    
    init(original: Memo, updatedContent: String) {
        self = original
        self.content = updatedContent
    }
}
