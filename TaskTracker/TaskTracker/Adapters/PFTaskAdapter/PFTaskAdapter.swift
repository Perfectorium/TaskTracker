//
//  File.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 30.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import Foundation

class PFTaskAdapter {
    
    
    // MARK: - LifeCycle
    
    
    init(withProjectID: String) {
        createObserverForChildAdded(toProjectID: withProjectID)
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



