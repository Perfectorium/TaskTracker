//
//  PFFileModel+CoreDataProperties.swift
//  
//
//  Created by Alex Tsonev on 29.06.17.
//
//

import Foundation
import CoreData


extension PFFileModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PFFileModel> {
        return NSFetchRequest<PFFileModel>(entityName: "PFFileModel")
    }

    @NSManaged public var fileId: String?
    @NSManaged public var type: String?
    @NSManaged public var url: String?
    @NSManaged public var comment: PFCommentModel?
    @NSManaged public var owner: PFUserModel?
    @NSManaged public var task: PFTaskModel?

}
