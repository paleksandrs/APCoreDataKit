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

class NSManagedObjectContextStackSetupTests: XCTestCase {
    
    
    func testManagedObjectContextWithSqlStoreNotNil() {
        
        let model = ManagedObjectModel(name: "TestModel", bundle: Bundle(for: type(of: self)))
        
        let moc = NSManagedObjectContext(model: model, storeType: PersistentStoreType.SQLite("TestModel"))

        XCTAssertNotNil(moc)
    }
}
