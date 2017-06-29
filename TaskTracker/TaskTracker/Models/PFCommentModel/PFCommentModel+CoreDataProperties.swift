//
//  PFCommentModel+CoreDataProperties.swift
//  
//
//  Created by Alex Tsonev on 29.06.17.
//
//

import Foundation
import CoreData


extension PFCommentModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PFCommentModel> {
        return NSFetchRequest<PFCommentModel>(entityName: "PFCommentModel")
    }

    @NSManaged public var commentId: String?
    @NSManaged public var date: String?
    @NSManaged public var text: String?
    @NSManaged public var timeToAdd: String?
    @NSManaged public var author: PFUserModel?
    @NSManaged public var files: NSSet?
    @NSManaged public var task: PFTaskModel?

}

// MARK: Generated accessors for files
extension PFCommentModel {

    @objc(addFilesObject:)
    @NSManaged public func addToFiles(_ value: PFFileModel)

    @objc(removeFilesObject:)
    @NSManaged public func removeFromFiles(_ value: PFFileModel)

    @objc(addFiles:)
    @NSManaged public func addToFiles(_ values: NSSet)

    @objc(removeFiles:)
    @NSManaged public func removeFromFiles(_ values: NSSet)

}
