//
//  RocketCore+CoreDataProperties.swift
//  
//
//  Created by Vineet Ravi on 24/04/18.
//
//

import Foundation
import CoreData


extension RocketCore {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RocketCore> {
        return NSFetchRequest<RocketCore>(entityName: "RocketCore")
    }

    @NSManaged public var block: String?
    @NSManaged public var coreSerial: String?
    @NSManaged public var flight: String?
    @NSManaged public var landingType: String?
    @NSManaged public var landingVehicle: String?
    @NSManaged public var landSuccess: Bool
    @NSManaged public var reused: Bool

}
