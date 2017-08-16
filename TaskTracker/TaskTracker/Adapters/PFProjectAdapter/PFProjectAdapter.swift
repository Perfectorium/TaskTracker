//
//  File.swift
//  TaskTracker
//
//  Created by Valeriy Jefimov on 04.07.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import Foundation


class PFProjectAdapter {
    
    // MARK: - LifeCycle
    
    
    init() {

    }
    
    
    // MARK: - Projects Management
    
    // Provides projects from Core Data to completionHandler, then updates projects
    // from a network, and transfers to completionHandler again
    func fetchProjects(completionHandler: @escaping (_ projects:[PFProjectModel]) -> Void) {
        self.projectsFromStorage(completionHandler: { (projects) in
            completionHandler(projects)
        })
        self.refreshProjectsList {
            PFCoreDataManager.shared.saveContext()
            self.projectsFromStorage(completionHandler: { (projects) in
                completionHandler(projects)
            })
        }
    }
    
    // Provides projects from Core Data to completionHandler
    private func projectsFromStorage(completionHandler: @escaping (_ projects:[PFProjectModel]) -> Void) {
        if let projectsController = PFCoreDataManager.shared.fetchedResultsControllerForProjects()
        {
            guard let fetchedProjects = projectsController.fetchedObjects
                else {
                    print("PFProjectAdapter: lazyVarProjects - nil")
                    return
            }
            completionHandler(fetchedProjects)
        }
    }
    
    // Returns a new NSManagedObject entity filled with provided values
    func newProject(withID projectId: String,
                    mainInfo: [String:String]) -> PFProjectModel {
        let entity = PFCoreDataManager.shared.newEntity(ofype: .project) as! PFProjectModel
        
        entity.name = mainInfo[kProjectName]
        entity.avatarUrl = mainInfo[kProjectAvatarURL]
        entity.client = mainInfo[kProjectClient]
        entity.descriptionText = mainInfo[kProjectDescription]
        entity.totalSpent = mainInfo[kProjectSpentTime]
        entity.totatEstimated = mainInfo[kProjectTotalEstimatedTime]
        entity.projectId = projectId
        return entity
    }
    
    // Updates an existing entity with provided values
    func update(project entity: PFProjectModel, withMainInfo mainInfo: [String:String]) {
        entity.name = mainInfo[kProjectName]
        entity.avatarUrl = mainInfo[kProjectAvatarURL]
        entity.client = mainInfo[kProjectClient]
        entity.descriptionText = mainInfo[kProjectDescription]
        entity.totalSpent = mainInfo[kProjectSpentTime]
        entity.totatEstimated = mainInfo[kProjectTotalEstimatedTime]
    }
    
    // Updates a projects list from a network
    func refreshProjectsList(completionHandler: @escaping () -> Void) {
        PFProjectFirebaseManager.getProjectList { (projectList) in
            var i = 0 // Needed to define, when to call completionHandler. Only at last iteration.
            for projectID in projectList {
                let predicate = NSPredicate(format: "projectId == %@", projectID)
                
                // If projectID exists - returns an object
                if let project = PFCoreDataManager.shared.fetchRecords(forEntity: .project,
                                                                       predicate: predicate).first
                {
                    PFProjectFirebaseManager.downloadMainInfo(projectID: projectID) { (success, result) in
                        self.update(project: project as! PFProjectModel, withMainInfo: result as! [String:String])
                        if i == projectList.count {
                            completionHandler()
                        }
                    }
                }
                else // Else - creates a new entity
                {
                    PFProjectFirebaseManager.downloadMainInfo(projectID: projectID) { (success, result) in
                        _ = self.newProject(withID: projectID, mainInfo: result as! [String:String])
                        if i == projectList.count {
                            completionHandler()
                        }
                    }
                }
                i += 1
            }
        }
    }
    
    
    // MARK: - Observers
    
    
    func createObserverForChildAdded() {
        
        let path = PFFirebaseManager.buildPath(withComponents: [kProjects])
        PFFirebaseManager.createObserver(of: .childAdded,
                                         path: path) { (success, snapshot) in
                                            guard let project = snapshot?.value as! [String:Any]?
                                                else {
                                                    return
                                            }
                                            if success
                                            {
                                                print(project)
                                            }
        }
    }
    
    func createObserverForChildRemoved() {
        let path = PFFirebaseManager.buildPath(withComponents: [kProjects])
        PFFirebaseManager.createObserver(of: .childRemoved,
                                         path: path) { (success, snapshot) in
                                            guard let project = snapshot?.value as! [String:Any]?
                                                else {
                                                    return
                                            }
                                            if success
                                            {
                                                print(project)
                                            }
        }
    }
    
    func createObserverForChildChanged() {
        let path = PFFirebaseManager.buildPath(withComponents: [kProjects])
        PFFirebaseManager.createObserver(of: .childChanged,
                                         path: path) { (success, snapshot) in
                                            guard let project = snapshot?.value as! [String:Any]?
                                                else {
                                                    return
                                            }
                                            if success
                                            {
                                                print(project)
                                            }
        }
    }
    
}
