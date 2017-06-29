//
//  PFUserModel+CoreDataProperties.swift
//  
//
//  Created by Alex Tsonev on 29.06.17.
//
//

import Foundation
import CoreData


extension PFUserModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PFUserModel> {
        return NSFetchRequest<PFUserModel>(entityName: "PFUserModel")
    }

    @NSManaged public var adminId: String?
    @NSManaged public var avatarUrl: String?
    @NSManaged public var email: String?
    @NSManaged public var name: String?
    @NSManaged public var phone: String?
    @NSManaged public var role: String?
    @NSManaged public var userId: String?
    @NSManaged public var comments: NSSet?
    @NSManaged public var files: NSSet?
    @NSManaged public var projects: NSSet?
    @NSManaged public var tasks: PFTaskModel?

}

// MARK: Generated accessors for comments
extension PFUserModel {

    @objc(addCommentsObject:)
    @NSManaged public func addToComments(_ value: PFCommentModel)

    @objc(removeCommentsObject:)
    @NSManaged public func removeFromComments(_ value: PFCommentModel)

    @objc(addComments:)
    @NSManaged public func addToComments(_ values: NSSet)

    @objc(removeComments:)
    @NSManaged public func removeFromComments(_ values: NSSet)

}

// MARK: Generated accessors for files
extension PFUserModel {

    @objc(addFilesObject:)
    @NSManaged public func addToFiles(_ value: PFFileModel)

    @objc(removeFilesObject:)
    @NSManaged public func removeFromFiles(_ value: PFFileModel)

    @objc(addFiles:)
    @NSManaged public func addToFiles(_ values: NSSet)

    @objc(removeFiles:)
    @NSManaged public func removeFromFiles(_ values: NSSet)

}

// MARK: Generated accessors for projects
extension PFUserModel {

    @objc(addProjectsObject:)
    @NSManaged public func addToProjects(_ value: PFProjectModel)

    @objc(removeProjectsObject:)
    @NSManaged public func removeFromProjects(_ value: PFProjectModel)

    @objc(addProjects:)
    @NSManaged public func addToProjects(_ values: NSSet)

    @objc(removeProjects:)
    @NSManaged public func removeFromProjects(_ values: NSSet)

}
