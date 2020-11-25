//
//  Memo.swift
//  SimpleMemo
//
//  Created by jaeyoung Yun on 2020/11/19.
//

import Foundation
import CoreData
import RxDataSources
import RxCoreData

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

extension Memo: Persistable {
    
    public static var entityName: String {
        return "Memo"
    }
    
    static var primaryAttributeName: String {
        return "identity"
    }
    
    init(entity: NSManagedObject) {
        content = entity.value(forKey: "content") as! String
        createdAt = entity.value(forKey: "createdAt") as! Date
        identity = entity.value(forKey: "identity") as! String
    }
    
    func update(_ entity: NSManagedObject) {
        entity.setValue(content, forKey: "content")
        entity.setValue(createdAt, forKey: "createdAt")
        entity.setValue(identity, forKey: "identity")
        
        do {
            try entity.managedObjectContext?.save()
        } catch {
            print(error)
        }
    }
}
