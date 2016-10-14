//
//  Created by Aleksandrs Proskurins
//
//  License
//  Copyright © 2016 Aleksandrs Proskurins
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

import CoreData

public extension NSManagedObjectContext {
    
    public convenience init(model: ManagedObjectModel, storeType: PersistentStoreType, concurrencyType: NSManagedObjectContextConcurrencyType = .mainQueueConcurrencyType) {
        self.init(concurrencyType: concurrencyType)
        
        persistentStoreCoordinator = getPersistentStoreCoordinator(withModel: model, storeType: storeType)
    }
    
    fileprivate func getPersistentStoreCoordinator(withModel model: ManagedObjectModel, storeType: PersistentStoreType) -> NSPersistentStoreCoordinator{
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model.managedObjectModel)
        let url = storeType.storePath()
        
        do {
            try coordinator.addPersistentStore(ofType: storeType.type, configurationName: nil, at: url as URL?, options: nil)
        } catch {
            fatalError("*** Failed to initialize the application's saved data ***")
        }
        
        return coordinator
    }
}

