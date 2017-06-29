//
//  PFCoreDatamanager.swift
//  TaskTracker
//
//  Created by Valeriy Jefimov on 29.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import UIKit
import CoreData

//tasks

let kPriority   = "priority"
let kStatus     = "status"
let kType       = "type"
let kTime       = "startTime"

//models

let kOwnerModel = "PFOwnerModel"


enum EntitiesObjects {
    case task
    case user
    case taskGroup
    case project
    case comment
    case file
    case owner
}

enum TaskSortDescriptors {
    case priority
    case type
    case status
    case time
}

class PFCoreDataManager: NSObject  {
    
    
    //MARK: - Vars & Constants
    
    
    static let  shared              = PFCoreDataManager()
    
    
    // MARK: - Core Data stack
    
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "TaskTracker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    
    // MARK: - Core Data Saving support
    
    
    private func context() -> NSManagedObjectContext {
        return persistentContainer.viewContext
    }
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    
    //MARK: - LifeCycle
    
    
    override init() {}
    
    func ownerUnique() -> PFOwnerModel {
        let owner           = self.fetchRecords(forEntity: .owner, predicate: nil).first as! PFOwnerModel
        return owner
    }
    
    private func fetchRequest(forEntity entity:EntitiesObjects) -> NSFetchRequest<NSFetchRequestResult> {
        var fetchRequest    = NSFetchRequest<NSFetchRequestResult>()
        
        switch entity {
        case .comment:
            fetchRequest    = PFCommentModel.fetchRequest()
            break
        case .file:
            fetchRequest    = PFFileModel.fetchRequest()
            break
        case .owner:
            fetchRequest    = PFOwnerModel.fetchRequest()
            break
        case .project:
            fetchRequest    = PFProjectModel.fetchRequest()
            break
        case .task:
            fetchRequest    = PFTaskModel.fetchRequest()
            break
        case .taskGroup:
            fetchRequest    = PFTaskGroupModel.fetchRequest()
            break
        case .user:
            fetchRequest    = PFUserModel.fetchRequest()
            break
        }
        return fetchRequest
    }
    
    
    //MARK: - FetchedResultsControllers
    
    
    private func fetchedResultsController(forEntity entity:EntitiesObjects) -> NSFetchedResultsController<NSFetchRequestResult> {
        let fetchRequest                = PFCoreDataManager.shared.fetchRequest(forEntity: entity)
        let fetchedResultsController    = NSFetchedResultsController(fetchRequest: fetchRequest,
                                                                     managedObjectContext: PFCoreDataManager.shared.context(),
                                                                     sectionNameKeyPath: nil,
                                                                     cacheName: nil)
        return fetchedResultsController
    }
    
    func fetchedResultsControllerForTasks(sortDescriptor:TaskSortDescriptors,
                                         ascending:Bool) -> NSFetchedResultsController<PFTaskModel>?   {
        let fetchedResultsController    = self.fetchedResultsController( forEntity: .task)
        switch sortDescriptor {
        case .priority:
            fetchedResultsController.fetchRequest.sortDescriptors = [NSSortDescriptor(key: kPriority,
                                                                                      ascending: ascending)]
            break
        case .status:
            fetchedResultsController.fetchRequest.sortDescriptors = [NSSortDescriptor(key: kPriority,
                                                                                      ascending: ascending)]
            break
        case .time:
            fetchedResultsController.fetchRequest.sortDescriptors = [NSSortDescriptor(key: kPriority,
                                                                                      ascending: ascending)]
            break
        case .type:
            fetchedResultsController.fetchRequest.sortDescriptors = [NSSortDescriptor(key: kPriority,
                                                                                      ascending: ascending)]
            break
            
        }
        do
        {
            try fetchedResultsController.performFetch()
        }
        catch
        {
            print(error.localizedDescription)
            return nil
        }
        return fetchedResultsController as? NSFetchedResultsController<PFTaskModel>
    }
    
    func fetchedResultsControllerForProjects() -> NSFetchedResultsController<PFProjectModel>?   {
        let fetchedResultsController = self.fetchedResultsController(forEntity: .project)
        fetchedResultsController.fetchRequest.sortDescriptors = [NSSortDescriptor(key: kName,
                                                                                  ascending: true)]
        do
        {
            try fetchedResultsController.performFetch()
        }
        catch
        {
            print(error.localizedDescription)
            return nil
        }
        return fetchedResultsController as? NSFetchedResultsController<PFProjectModel>
    }
    
    func fetchedResultsControllerForFiles() -> NSFetchedResultsController<PFFileModel>?   {
        let fetchedResultsController = self.fetchedResultsController(forEntity: .file)
        fetchedResultsController.fetchRequest.sortDescriptors = [NSSortDescriptor(key: kName,
                                                                                  ascending: true)]
        do
        {
            try fetchedResultsController.performFetch()
        }
        catch
        {
            print(error.localizedDescription)
            return nil
        }
        return fetchedResultsController as? NSFetchedResultsController<PFFileModel>
    }
    
    func fetchedResultsControllerForUsers() -> NSFetchedResultsController<PFUserModel>?   {
        let fetchedResultsController = self.fetchedResultsController(forEntity: .user)
        fetchedResultsController.fetchRequest.sortDescriptors = [NSSortDescriptor(key: kName,
                                                                                  ascending: true)]
        do
        {
            try fetchedResultsController.performFetch()
        }
        catch
        {
            print(error.localizedDescription)
            return nil
        }
        return fetchedResultsController as? NSFetchedResultsController<PFUserModel>
    }
    
    
    //MARK: - Entities
    
    
    func delete(object: NSManagedObject) {
        persistentContainer.viewContext.delete(object)
    }
    
    func deleteAllObjects(ofEntity entity:EntitiesObjects) {
        let fetchRequest                    = PFCoreDataManager.shared.fetchRequest(forEntity: entity)
        fetchRequest.includesPropertyValues = false
        do {
            let items                       = try persistentContainer.viewContext.fetch(fetchRequest) as! [NSManagedObject]
            
            for item in items {
                persistentContainer.viewContext.delete(item)
            }
            
        } catch {
            print ("There was an error")
            
        }
    }
    
    func newEntity(ofype type:EntitiesObjects) -> NSManagedObject {
        let context = self.context()
        
        switch type {
        case .comment:
            return PFCommentModel(context: context)
        case .file:
            return PFFileModel(context: context)
        case .owner:
            return PFOwnerModel(context: context)
        case .project:
            return PFProjectModel(context: context)
        case .task:
            return PFTaskModel(context: context)
        case .taskGroup:
            return PFTaskGroupModel(context: context)
        case .user:
            return PFUserModel(context: context)
        }
    }
    
    
    func getById(id: NSManagedObjectID) -> Any? {
        return self.context().object(with: id) as Any
    }
    
    func fetchRecords(forEntity entity:EntitiesObjects,
                      predicate:NSPredicate?) -> [NSManagedObject] {
        let fetchRequest    = self.fetchRequest(forEntity: entity)
        var result          = [NSManagedObject]()
        if predicate != nil
        {
            fetchRequest.predicate = predicate
        }
        
        do
        {
            
            let records     = try context().fetch(fetchRequest)
            
            if let records  = records as? [NSManagedObject] {
                result = records
            }
            
        }
        catch
        {
            print("Unable to fetch managed objects for entity \(entity).".localized)
        }
        
        return result
    }
    
    func count(ofEntities entity:EntitiesObjects) -> Int {
        let context         = persistentContainer.viewContext
        let fetchRequest    = self.fetchRequest(forEntity: entity)
        do {
            let count           = try context.count(for: fetchRequest)
            return count
        }
        catch
        {
            return 0
        }
        
    }
    
    func checkQuantity(ofEntity entity:EntitiesObjects) {
        if self.count(ofEntities: entity) > 4000
        {
            self.deleteAllObjects(ofEntity: entity)
        }
    }
    
}



