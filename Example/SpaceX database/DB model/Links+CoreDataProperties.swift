//
//  Links+CoreDataProperties.swift
//  
//
//  Created by Vineet Ravi on 24/04/18.
//
//

import Foundation
import CoreData


extension Links {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Links> {
        return NSFetchRequest<Links>(entityName: "Links")
    }

    @NSManaged public var articleLink: URL?
    @NSManaged public var missionPatch: URL?
    @NSManaged public var missionPatchSmall: URL?
    @NSManaged public var presskit: URL?
    @NSManaged public var redditCampaign: URL?
    @NSManaged public var redditLaunch: URL?
    @NSManaged public var redditMedia: URL?
    @NSManaged public var redditRecovery: URL?
    @NSManaged public var videoLink: URL?

}
