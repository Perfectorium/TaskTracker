//
//  File.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 30.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import Foundation

class PFTaskAdapter {
    
    static func add(task: PFTaskModel) {
        
        let taskTuple = PFTaskModel.convertToDictionary(task: task)
        PFProjectFirebaseManager.addTask(task: taskTuple.info,
                                         withID: taskTuple.id,
                                         projectID: "") { (success) in
                                            if success
                                            {
                                                print("some code")
                                            }
                                            else
                                            {
                                                print("some sad code")
                                            }
        }
        
    }
    
}



