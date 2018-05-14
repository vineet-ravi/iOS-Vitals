//
//  Telemetry+CoreDataProperties.swift
//  
//
//  Created by Vineet Ravi on 24/04/18.
//
//

import Foundation
import CoreData


extension Telemetry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Telemetry> {
        return NSFetchRequest<Telemetry>(entityName: "Telemetry")
    }

    @NSManaged public var flightClub: String?

}
