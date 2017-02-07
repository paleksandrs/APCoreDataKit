//
//  Created by Aleksandrs Proskurins
//
//  License
//  Copyright © 2016 Aleksandrs Proskurins
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

import CoreData

public extension NSManagedObjectContext {
    
    public func createAndInsert<T : NSManagedObject>(entity: T.Type) -> T {
        
        var object: T?
        
        performAndWait {
            
            let entityName = String(describing: entity)
            object = NSEntityDescription.insertNewObject(forEntityName: entityName, into:self) as? T
        }

        return object!
    }
    
    public func performFetch<T: NSManagedObject>(request: NSFetchRequest<NSFetchRequestResult>) throws -> [T] {

        var results = [AnyObject]()
        var caughtError: NSError?
        
        performAndWait {
            do {
                results = try self.fetch(request)
            }
            catch {
                caughtError = error as NSError
            }
        }
        
        guard caughtError == nil else {
            throw caughtError!
        }
        
        return results as! [T]
    }
    
    public func saveContext(andWait wait: Bool = true, success: (() -> Void)? = nil, failure: ((NSError) -> Void)? = nil) {
        
        let saveBlock = {
            
            guard self.hasChanges else {
                return
            }
            
            do {
                try self.save()
                success?()
            }
            catch {
                failure?(error as NSError)
            }
        }
        wait ? performAndWait(saveBlock) : perform(saveBlock)
    }
    
    public func delete<T: NSManagedObject>(objects: [T]) {
        
        guard objects.count != 0 else { return }
        
        performAndWait {
            for each in objects {
                self.delete(each)
            }
        }
    }
    
    public func delete<T : NSManagedObject>(entity: T.Type) throws {
        
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: String(describing: entity))
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        try self.persistentStoreCoordinator!.execute(deleteRequest, with: self)
    }
    
    func getObject<T: NSManagedObject>(objectURL: String) -> T? {
        
        guard let url = URL(string: objectURL) else {
            
            return nil
        }
        guard let managedObjectID = persistentStoreCoordinator?.managedObjectID(forURIRepresentation: url) else {
            
            return nil
        }
        
        var obj: T?
        performAndWait {
            
            obj = self.object(with: managedObjectID) as? T
        }
        return obj
    }
}

