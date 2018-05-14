//
//  RocketFirstStage+CoreDataProperties.swift
//  
//
//  Created by Vineet Ravi on 24/04/18.
//
//

import Foundation
import CoreData


extension RocketFirstStage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RocketFirstStage> {
        return NSFetchRequest<RocketFirstStage>(entityName: "RocketFirstStage")
    }

    @NSManaged public var cores: NSSet?

}

// MARK: Generated accessors for cores
extension RocketFirstStage {

    @objc(addCoresObject:)
    @NSManaged public func addToCores(_ value: RocketCore)

    @objc(removeCoresObject:)
    @NSManaged public func removeFromCores(_ value: RocketCore)

    @objc(addCores:)
    @NSManaged public func addToCores(_ values: NSSet)

    @objc(removeCores:)
    @NSManaged public func removeFromCores(_ values: NSSet)

}
