//
//  Reuse+CoreDataProperties.swift
//  
//
//  Created by Vineet Ravi on 24/04/18.
//
//

import Foundation
import CoreData


extension Reuse {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reuse> {
        return NSFetchRequest<Reuse>(entityName: "Reuse")
    }

    @NSManaged public var capsule: Bool
    @NSManaged public var core: Bool
    @NSManaged public var fairings: Bool
    @NSManaged public var sideCore1: Bool
    @NSManaged public var sideCore2: Bool

}
