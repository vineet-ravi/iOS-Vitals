//
//  RocketSecondStage+CoreDataProperties.swift
//  
//
//  Created by Vineet Ravi on 24/04/18.
//
//

import Foundation
import CoreData


extension RocketSecondStage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RocketSecondStage> {
        return NSFetchRequest<RocketSecondStage>(entityName: "RocketSecondStage")
    }

    @NSManaged public var payloads: NSSet?

}

// MARK: Generated accessors for payloads
extension RocketSecondStage {

    @objc(addPayloadsObject:)
    @NSManaged public func addToPayloads(_ value: RocketPayload)

    @objc(removePayloadsObject:)
    @NSManaged public func removeFromPayloads(_ value: RocketPayload)

    @objc(addPayloads:)
    @NSManaged public func addToPayloads(_ values: NSSet)

    @objc(removePayloads:)
    @NSManaged public func removeFromPayloads(_ values: NSSet)

}
