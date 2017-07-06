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
//        createObserverForChildAdded()
//        createObserverForChildChanged()
//        createObserverForChildRemoved()
        //let project = PFCoreDataManager.shared.newEntity(ofype: .project) as! PFProjectModel
        //project.projectId = "ProjectName3"
        //project.name = "ProjectName3"
        //PFCoreDataManager.shared.saveContext()
        //print(project)
        let projectsController = PFCoreDataManager.shared.fetchedResultsControllerForProjects()
        let fetchedProjects = projectsController?.fetchedObjects
        print(fetchedProjects)
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
