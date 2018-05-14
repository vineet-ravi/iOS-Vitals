//
//  RocketInfo+CoreDataProperties.swift
//  
//
//  Created by Vineet Ravi on 24/04/18.
//
//

import Foundation
import CoreData


extension RocketInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<RocketInfo> {
        return NSFetchRequest<RocketInfo>(entityName: "RocketInfo")
    }

    @NSManaged public var rocketID: String?
    @NSManaged public var rocketName: String?
    @NSManaged public var rocketType: String?
    @NSManaged public var firstStage: RocketFirstStage?
    @NSManaged public var secondStage: RocketSecondStage?

}
