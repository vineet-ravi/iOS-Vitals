//
//  LaunchSite+CoreDataProperties.swift
//  
//
//  Created by Vineet Ravi on 24/04/18.
//
//

import Foundation
import CoreData


extension LaunchSite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LaunchSite> {
        return NSFetchRequest<LaunchSite>(entityName: "LaunchSite")
    }

    @NSManaged public var siteID: String?
    @NSManaged public var siteName: String?
    @NSManaged public var siteNameLong: String?

}
