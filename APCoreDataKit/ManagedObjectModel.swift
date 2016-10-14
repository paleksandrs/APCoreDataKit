//
//  Created by Aleksandrs Proskurins
//
//  License
//  Copyright © 2016 Aleksandrs Proskurins
//  Released under an MIT license: http://opensource.org/licenses/MIT
//

import CoreData
import Foundation

public struct  ManagedObjectModel {
    
    public let name: String
    public let bundle: Bundle
    public var managedObjectModel: NSManagedObjectModel {
        get {
            guard let modelURL = bundle.url(forResource: name, withExtension: "momd") else {
                fatalError("*** Error loading model ***")
            }
            
            return NSManagedObjectModel(contentsOf: modelURL)!
        }
    }
    
    public init(name: String, bundle: Bundle = .main) {
        self.name = name
        self.bundle = bundle
    }
}
