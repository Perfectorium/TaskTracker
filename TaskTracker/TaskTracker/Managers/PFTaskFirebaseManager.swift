//
//  PFTaskFirebaseManager.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 29.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import Foundation

class PFTaskFirebaseManager: PFFirebaseManager {
    
    class func add(task: [String:Any],
                   withID taskId: String, //PFTaskModel,
        toProjectID projectID: String,
        completionHandler outerHandler: @escaping (_ success: Bool) -> Void) {
        
        let uploadPath = buildPath(withComponents: [kProjects,
                                                    projectID,
                                                    kTasks,
                                                    taskId])
        setDatabase(value: task,
                    forPath: uploadPath) { (success) in
                        outerHandler(success)
        }
    }
    
    class func update(task: PFTaskModel,
                      withValues: [String],
                      completionHandler outerHandler: @escaping (_ success: Bool) -> Void) {
        
        
    }
    
    class func add(comment: [String:Any],
                   withID commentId: String,
                   toProjectID projectId: String,
                   andTaskID taskId: String,
                   completionHandler outerHandler: @escaping (_ success: Bool) -> Void) {
        
        let uploadPath = buildPath(withComponents: [kProjects,
                                                    projectId,
                                                    kComments,
                                                    commentId])
        PFCommentFirebaseManager.add(comment: comment,
                                     atPath: uploadPath) { (success) in
                                        if success
                                        {
                                            let uploadPath = buildPath(withComponents: [kProjects,
                                                                                        projectId,
                                                                                        kTasks,
                                                                                        taskId,
                                                                                        kTaskComments,
                                                                                        commentId])
                                            setDatabase(value: true,
                                                        forPath: uploadPath,
                                                        completionHandler: { (success) in
                                                            outerHandler(success)
                                            })
                                            
                                        }
                                        else
                                        {
                                            outerHandler(false)
                                        }
        }
    }
    
    // Поменять пользователя, добавить пользователя позже? Удалить и переназначить пользователя на таску.
    
    class func move(taskWithID: String,
                    withProjectID projectID: String,
                    fromUserID: String,
                    toUserID: String,
                    completionHandler outerHandler: @escaping (_ success: Bool) -> Void) {
        
        let uploadPath = buildPath(withComponents: [kProjects,
                                                    projectID,
                                                    kTasks,
                                                    taskWithID,
                                                    kUsers])
        
        let toPath = uploadPath.appending("/\(toUserID)")
        setDatabase(value: true,
                    forPath: toPath) { (success) in
                        if(success)
                        {
                            let uploadPath = buildPath(withComponents: [kProjects,
                                                                        projectID,
                                                                        kTasks,
                                                                        taskWithID,
                                                                        kUsers])
                            let path = uploadPath.appending("/\(fromUserID)")
                            setDatabase(value: nil,
                                        forPath: path,
                                        completionHandler: { (success) in
                                            outerHandler(success)
                            })
                        }
                        else
                        {
                            outerHandler(false)
                        }
        }
        
    }
}
