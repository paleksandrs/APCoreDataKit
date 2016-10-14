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

class ManagedObjectModelTests: XCTestCase {
    
    var managedObjectModel: ManagedObjectModel!
    var unitTestBundle: Bundle!
    
    override func setUp() {
        super.setUp()
        
        unitTestBundle  = Bundle(for: type(of: self))
        
        managedObjectModel = ManagedObjectModel(name: "TestModel", bundle: unitTestBundle)
    }

    func testInitSetsModelName() {
        
        XCTAssertEqual(managedObjectModel.name, "TestModel")
    }
    
    func testInitSetsBundle() {
        
        XCTAssertEqual(managedObjectModel.bundle, unitTestBundle)
    }
    
    func testManagedObjectModelReturnsObject() {
        
        XCTAssertNotNil(managedObjectModel.managedObjectModel)
    }
}
