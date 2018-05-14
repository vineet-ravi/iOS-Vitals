//
//  RocketPayload+CoreDataProperties.swift
//  
//
//  Created by Vineet Ravi on 24/04/18.
//
//

import Foundation
import CoreData


extension RocketPayload {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RocketPayload> {
        return NSFetchRequest<RocketPayload>(entityName: "RocketPayload")
    }

    @NSManaged public var orbit: String?
    @NSManaged public var payloadID: String?
    @NSManaged public var payloadMassKG: String?
    @NSManaged public var payloadMassLBS: String?
    @NSManaged public var payloadType: String?
    @NSManaged public var reused: Bool
    @NSManaged public var customers: NSSet?

}

// MARK: Generated accessors for customers
extension RocketPayload {

    @objc(addCustomersObject:)
    @NSManaged public func addToCustomers(_ value: Customer)

    @objc(removeCustomersObject:)
    @NSManaged public func removeFromCustomers(_ value: Customer)

    @objc(addCustomers:)
    @NSManaged public func addToCustomers(_ values: NSSet)

    @objc(removeCustomers:)
    @NSManaged public func removeFromCustomers(_ values: NSSet)

}
