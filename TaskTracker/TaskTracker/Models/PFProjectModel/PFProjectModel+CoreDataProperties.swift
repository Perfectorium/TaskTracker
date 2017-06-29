//
//  PFProjectModel+CoreDataProperties.swift
//  
//
//  Created by Alex Tsonev on 29.06.17.
//
//

import Foundation
import CoreData


extension PFProjectModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PFProjectModel> {
        return NSFetchRequest<PFProjectModel>(entityName: "PFProjectModel")
    }

    @NSManaged public var adminId: String?
    @NSManaged public var avatarUrl: String?
    @NSManaged public var client: String?
    @NSManaged public var descriptionText: String?
    @NSManaged public var name: String?
    @NSManaged public var projectId: String?
    @NSManaged public var totalSpent: String?
    @NSManaged public var totatEstimated: String?
    @NSManaged public var tasks: NSSet?
    @NSManaged public var users: NSSet?

}

// MARK: Generated accessors for tasks
extension PFProjectModel {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: PFTaskModel)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: PFTaskModel)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}

// MARK: Generated accessors for users
extension PFProjectModel {

    @objc(addUsersObject:)
    @NSManaged public func addToUsers(_ value: PFUserModel)

    @objc(removeUsersObject:)
    @NSManaged public func removeFromUsers(_ value: PFUserModel)

    @objc(addUsers:)
    @NSManaged public func addToUsers(_ values: NSSet)

    @objc(removeUsers:)
    @NSManaged public func removeFromUsers(_ values: NSSet)

}
