//
//  Headquarter+CoreDataProperties.swift
//  
//
//  Created by Vineet Ravi on 25/04/18.
//
//

import Foundation
import CoreData


extension Headquarter {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Headquarter> {
        return NSFetchRequest<Headquarter>(entityName: "Headquarter")
    }

    @NSManaged public var address: String?
    @NSManaged public var city: String?
    @NSManaged public var state: String?

}
