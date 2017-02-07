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
    
    func testInsertingObjectIntoChildContextIncrementsObjectCountInParent() {
        
        let moc = createContextWithPersistentStoreType(PersistentStoreType.InMemory)
        let child = moc.child()
        
        let personsArray = fetchAllPersons(inMOC: moc)
        
        _ = child.createAndInsert(entity: Person.self)
     
        child.saveContext()
        
        let personsArrayAfter = fetchAllPersons(inMOC: moc)
        
        XCTAssertEqual(personsArray.count+1, personsArrayAfter.count)
    }
    
    //MARK : Helpers
    
    func createContextWithPersistentStoreType(_ type: PersistentStoreType) -> NSManagedObjectContext {
        
        let model = ManagedObjectModel(name: "TestModel", bundle: Bundle(for: type(of: self)))
        
        return NSManagedObjectContext(model: model, storeType: type)
    }
    
    func fetchAllPersons(inMOC moc: NSManagedObjectContext) -> [Person] {
        
        let fetchRequest = Person.entityFetchRequest()
        var personArray = [Person]()
        
        do {
            personArray = try moc.performFetch(request: fetchRequest)
        }catch {
            XCTAssertTrue(false)
        }
        return personArray
    }
}
