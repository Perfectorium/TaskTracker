//
//  File.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 30.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import Foundation

class PFTaskAdapter {
    
    
    // MARK: - Properties 
    
    var projID: String!
  //  let projectID: String!
    
    
    // MARK: - LifeCycle
    init() {
        
    }
    
    
//    init(withProjectID: String) {
//        projectID = withProjectID
//    }
    
    func fetchTasks(projectID: String, completionHandler: @escaping (_ tasks: [PFTaskModel]) -> Void) {
       projID = projectID
        self.tasksFromStorage(projectID: self.projID, completionHandler: { (tasks) in
        print("!!!")
        print(self.projID!)
        completionHandler(tasks)
        })
        
        self.refreshTasksList(projectID: projID!) {
        PFCoreDataManager.shared.saveContext()
        self.tasksFromStorage(projectID: self.projID, completionHandler: { (tasks) in
        completionHandler(tasks)
        })
        }
  
    }
    
    private func tasksFromStorage(projectID: String, completionHandler: @escaping (_ tasks: [PFTaskModel]) -> Void) {
        if let tasksController = PFCoreDataManager.shared.fetchedResultsControllerForTasks(){
        guard let fetchedTasks = tasksController.fetchedObjects
        else {
        print("PFTaskAdapter: lazyVarTasks - nil")
        return
        }
        print("!!!")
        print(fetchedTasks.count)
        completionHandler(fetchedTasks)
        }
        
    }
    
    func newTask(project id: String, taskID: String, mainInfo: [String: String]) -> PFTaskModel {
        let entity = PFCoreDataManager.shared.newEntity(ofype: .task) as! PFTaskModel
        entity.name = mainInfo[kTaskName]
        entity.authorId = mainInfo[kTaskAuthor]
        entity.status = mainInfo[kTaskStatus]
        entity.taskId = taskID
        
        return entity
    }
    
    func update(task entity: PFTaskModel, withMainInfo mainInfo: [String: String]) {
        entity.name = mainInfo[kTaskName]
        entity.authorId = mainInfo[kTaskAuthor]
        entity.status = mainInfo[kTaskStatus]
    }
    
    func refreshTasksList(projectID: String, completionHandler: @escaping () -> Void) {
        PFTaskFirebaseManager.getTasksList(projectID: projectID) { (taskList) in
    var i = 0 // Needed to define, when to call completionHandler. Only at last iteration.
            for taskString in taskList {
                let predicate = NSPredicate(format: "tasId == %@", taskString)
                
                // If projectID exists - returns an object
                if let task = PFCoreDataManager.shared.fetchRecords(forEntity: .task, predicate: predicate).first {
                    PFTaskFirebaseManager.downloadMainInfo(projectID: projectID, taskID: taskString) { (success, result) in
                        self.update(task: task as! PFTaskModel, withMainInfo: result as! [String: String])
                        if i == taskList.count {
                            completionHandler()
                        }
                    }
                }
                else { // Else - creates a new entity
                    PFTaskFirebaseManager.downloadMainInfo(projectID: projectID, taskID: taskString){ (success, result) in
                        _ = self.newTask(project: projectID, taskID: taskString, mainInfo: result as! [String : String])
                        if i == taskList.count {
                            completionHandler()
                        }
                    }
                }
                i += 1
            }
        
        }
    }
    
//    private func tasksFromStorage(completionHandler: @escaping (_ projects:[PFTaskModel]) -> Void) {
//        PFCoreDataManager.shared.saveContext()
////        if let projectsController = PFCoreDataManager.shared.fetch)
////        {
////            guard let fetchedTasks = projectsController.fetchedObjects
////                else {
////                    print("PFProjectAdapter: lazyVarProjects - nil")
////                    return
////            }
////            completionHandler(fetchedTasks)
////        }
//    }
    
    
    // MARK: - Observers
    
    //TODO: - check if it works for tasks!!
    func createObserverForChildAdded(toProjectID projectID: String) {
        
        let path = PFFirebaseManager.buildPath(withComponents: [kProjects,projectID,kProjectTasks])
        PFFirebaseManager.createObserver(of: .childAdded,
                                         path: path) { (success, snapshot) in
                                            guard let task = snapshot?.value as! [String:Any]?
                                                else {
                                                    return
                                            }
                                            if success
                                            {
                                                print(task)
                                            }
        }
    }
    
}



