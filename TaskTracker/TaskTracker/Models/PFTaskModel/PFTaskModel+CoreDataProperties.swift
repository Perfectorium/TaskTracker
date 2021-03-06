//
//  PFTaskModel+CoreDataProperties.swift
//  
//
//  Created by Alex Tsonev on 29.06.17.
//
//

import Foundation
import CoreData


extension PFTaskModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PFTaskModel> {
        return NSFetchRequest<PFTaskModel>(entityName: "PFTaskModel")
    }

    @NSManaged public var authorId: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var endTime: String?
    @NSManaged public var estimatedTime: String?
    @NSManaged public var name: String?
    @NSManaged public var priority: String?
    @NSManaged public var startTime: String?
    @NSManaged public var status: String?
    @NSManaged public var type: String?
    @NSManaged public var comments: NSSet?
    @NSManaged public var project: PFProjectModel?
    @NSManaged public var users: PFUserModel?
    @NSManaged public var taskGroup: PFTaskGroupModel?

}

// MARK: Generated accessors for comments
extension PFTaskModel {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: PFCommentModel)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: PFCommentModel)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: NSSet)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: NSSet)

}
