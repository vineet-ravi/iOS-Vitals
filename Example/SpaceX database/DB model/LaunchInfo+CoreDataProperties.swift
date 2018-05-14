//
//  LaunchInfo+CoreDataProperties.swift
//  
//
//  Created by Vineet Ravi on 24/04/18.
//
//

import Foundation
import CoreData


extension LaunchInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LaunchInfo> {
        return NSFetchRequest<LaunchInfo>(entityName: "LaunchInfo")
    }

    @NSManaged public var details: String?
    @NSManaged public var flightNumber: String?
    @NSManaged public var launchDateLocal: String?
    @NSManaged public var launchDateUnix: String?
    @NSManaged public var launchDateUTC: String?
    @NSManaged public var launchSuccess: Bool
    @NSManaged public var launchYear: String?
    @NSManaged public var launchSite: LaunchSite?
    @NSManaged public var link: Links?
    @NSManaged public var reuse: Reuse?
    @NSManaged public var rocket: RocketInfo?
    @NSManaged public var telemetry: Telemetry?

}
