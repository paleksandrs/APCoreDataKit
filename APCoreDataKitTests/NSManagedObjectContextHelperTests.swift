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

class NSManagedObjectContextHelperTests: XCTestCase {
    
    var sqlMoc: NSManagedObjectContext!
    
    override func setUp() {
        super.setUp()
        
        sqlMoc = createContextWithPersistentStoreType(PersistentStoreType.SQLite("TestModel"))
    }
    
    override func tearDown() {
        super.tearDown()
        
        do { try sqlMoc.delete(entity: Person.self)}catch {}
    }
    
    func testInsertingObjectIntoContextIncrementsObjectCount() {
        
        let moc = createContextWithPersistentStoreType(PersistentStoreType.InMemory)
        
        let personsArray = fetchAllPersons(inMOC: moc)
        
        _ = moc.createAndInsert(entity: Person.self)
        
        let personsArrayAfter = fetchAllPersons(inMOC: moc)
        
        XCTAssertEqual(personsArray.count+1, personsArrayAfter.count)
    }
    
    func testDeletingObjectFromContextDecrementsObjectCount() {
        
        let moc = createContextWithPersistentStoreType(PersistentStoreType.InMemory)
        let person = moc.createAndInsert(entity: Person.self)
        let personsArray = fetchAllPersons(inMOC: moc)
        
        moc.delete(objects: [person])
        
        let personsArrayAfter = fetchAllPersons(inMOC: moc) 
        
        XCTAssertEqual(personsArray.count-1, personsArrayAfter.count)
    }
    
    func testDeletingAllObjectFromContextSetsObjectCountToZero() {
    
        _ = sqlMoc.createAndInsert(entity: Person.self)
        _ = sqlMoc.createAndInsert(entity: Person.self)
    
        do {
            try sqlMoc.delete(entity: Person.self)
        }catch {
            XCTAssertTrue(false)
        }
        
        sqlMoc.reset()
        
        let personsArrayAfter = fetchAllPersons(inMOC: sqlMoc)
        
        XCTAssertEqual(personsArrayAfter.count, 0)
    }
    
    func testSavingContextSavesChangesToStore() {
        
        let personsArray = fetchAllPersons(inMOC: sqlMoc)
        
        _ = sqlMoc.createAndInsert(entity: Person.self)
        
        sqlMoc.saveContext()
        
        let moc2 = createContextWithPersistentStoreType(PersistentStoreType.SQLite("TestModel"))
        
        let personsArrayInMOC2 = fetchAllPersons(inMOC: moc2)
        
        XCTAssertEqual(personsArray.count+1, personsArrayInMOC2.count)
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
