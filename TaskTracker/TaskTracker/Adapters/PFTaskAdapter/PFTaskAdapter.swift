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
    
    
    let projectID: String!
    
    
    // MARK: - LifeCycle
    
    
    init(withProjectID: String) {
        projectID = withProjectID
    }
    
    private func tasksFromStorage(completionHandler: @escaping (_ projects:[PFTaskModel]) -> Void) {
        PFCoreDataManager.shared.saveContext()
//        if let projectsController = PFCoreDataManager.shared.fetch)
//        {
//            guard let fetchedTasks = projectsController.fetchedObjects
//                else {
//                    print("PFProjectAdapter: lazyVarProjects - nil")
//                    return
//            }
//            completionHandler(fetchedTasks)
//        }
    }
    
    
    // MARK: - Observers
    
    
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



