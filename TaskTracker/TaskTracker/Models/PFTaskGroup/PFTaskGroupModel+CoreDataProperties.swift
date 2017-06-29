//
//  PFTaskGroupModel+CoreDataProperties.swift
//  
//
//  Created by Alex Tsonev on 29.06.17.
//
//

import Foundation
import CoreData


extension PFTaskGroupModel {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<PFTaskGroupModel> {
        return NSFetchRequest<PFTaskGroupModel>(entityName: "PFTaskGroupModel")
    }

    @NSManaged public var groupId: String?
    @NSManaged public var startTime: String?
    @NSManaged public var endTime: String?
    @NSManaged public var estimatedTime: String?
    @NSManaged public var tasks: NSSet?

}

// MARK: Generated accessors for tasks
extension PFTaskGroupModel {

    @objc(addTasksObject:)
    @NSManaged public func addToTasks(_ value: PFTaskModel)

    @objc(removeTasksObject:)
    @NSManaged public func removeFromTasks(_ value: PFTaskModel)

    @objc(addTasks:)
    @NSManaged public func addToTasks(_ values: NSSet)

    @objc(removeTasks:)
    @NSManaged public func removeFromTasks(_ values: NSSet)

}
