//
//  Company+CoreDataProperties.swift
//  
//
//  Created by Vineet Ravi on 25/04/18.
//
//

import Foundation
import CoreData


extension Company {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Company> {
        return NSFetchRequest<Company>(entityName: "Company")
    }

    @NSManaged public var name: String?
    @NSManaged public var founder: String?
    @NSManaged public var founded: String?
    @NSManaged public var employees: String?
    @NSManaged public var vehicles: String?
    @NSManaged public var launchSites: String?
    @NSManaged public var testSites: String?
    @NSManaged public var ceo: String?
    @NSManaged public var cto: String?
    @NSManaged public var coo: String?
    @NSManaged public var ctoPropulsion: String?
    @NSManaged public var valuation: String?
    @NSManaged public var summary: String?
    @NSManaged public var headquarter: Headquarter?

}
