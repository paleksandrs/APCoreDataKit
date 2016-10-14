//
//  Created by Aleksandrs Proskurins
//
//  License
//  Copyright © 2016 Aleksandrs Proskurins
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

import CoreData
import Foundation


public enum PersistentStoreType {
    
    case SQLite (String)
    case InMemory
    
    public var type: String {
        get {
            switch self {
            case .SQLite: return NSSQLiteStoreType
            case .InMemory: return NSInMemoryStoreType
            }
        }
    }
    
    public func storePath() -> URL? {
        switch self {
        case let .SQLite(name): return sqlURL(name)
        case .InMemory: return nil
        }
    }
    
    fileprivate func sqlURL(_ name: String) -> URL {
        
        do {
            let url = try FileManager.default.url(
                for: .documentDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: false)
            return url.appendingPathComponent("\(name).sqlite")
        }
        catch {
            fatalError("*** Error finding document path ***")
        }
    }
    
}
