//
//  Customer+CoreDataProperties.swift
//  
//
//  Created by Vineet Ravi on 24/04/18.
//
//

import Foundation
import CoreData


extension Customer {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Customer> {
        return NSFetchRequest<Customer>(entityName: "Customer")
    }

    @NSManaged public var name: String?

}
