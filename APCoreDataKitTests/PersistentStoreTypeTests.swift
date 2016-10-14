//
//  Created by Aleksandrs Proskurins
//
//  License
//  Copyright © 2016 Aleksandrs Proskurins
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

import XCTest
@testable import APCoreDataKit
import CoreData

class PersistentStoreTypeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()

    }

    func testTypeForSQLite_NSSQLiteStoreType() {
        
        let storeType = PersistentStoreType.SQLite("")
        
        XCTAssertEqual(storeType.type, NSSQLiteStoreType) 
    }
    
    func testTypeForInMemory_NSInMemoryStoreType() {
        
        let storeType = PersistentStoreType.InMemory
        
        XCTAssertEqual(storeType.type, NSInMemoryStoreType)
    }
    
    func testStorePathorForInMemoryIsNil() {
        
        let storeType = PersistentStoreType.InMemory
        
        XCTAssertNil(storeType.storePath())
    }
    
    func testStorePathForSQLiteIsFile() {
        
        let storeType = PersistentStoreType.SQLite("TestDB")
        let urlString = storeType.storePath()!.absoluteString
        
        XCTAssertTrue(urlString.hasSuffix("/Documents/TestDB.sqlite"))
    }
}
