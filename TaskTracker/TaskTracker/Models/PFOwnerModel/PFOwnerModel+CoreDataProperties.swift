//
//  PFOwnerModel+CoreDataProperties.swift
//  
//
//  Created by Alex Tsonev on 29.06.17.
//
//

import Foundation
import CoreData


extension PFOwnerModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PFOwnerModel> {
        return NSFetchRequest<PFOwnerModel>(entityName: "PFOwnerModel")
    }

    @NSManaged public var ownerId: String?

}
