//
//  PFTaskFirebaseManager.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 29.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import Foundation
import FirebaseDatabase


class PFTaskFirebaseManager: PFFirebaseManager {
    
    
    class func downloadMainInfo(projectID: String,
                                taskID: String,
                                completionHandler: @escaping (_ success: Bool,
        _ projectInfo: [String: Any]) -> Void) {
        
        let path = buildPath(withComponents: [kProjects, projectID, kTasks, taskID, kMainInfo])
        
        fetchDatabase(withPath: path) { (result) in
            guard let response = result as! [String: Any]?
                else {
                   printError("downloadMainInfoError: result is nil")
                    completionHandler(false, [:])
                    return
            }
                      completionHandler(true, response)
        }
    }
    
    class func getTasksList(projectID: String,
                            completionHandler: @escaping (_ tasks: [String]) -> Void) {
        let path = buildPath(withComponents: [kProjects, projectID, kTasks])
        
        fetchDatabase(withPath: path) { (result) in
            guard let response = result as! [String: Any]?
                else {
                    printError("getProjectsListError: projects is nil")
                    completionHandler([])
                    return
            }
            let tasks = Array(response.keys)
            completionHandler(tasks)
        }
    }
    
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
    
    class func add(comment aComment: [String:Any],
                   withID aCommentId: String,
                   toProjectID projectId: String,
                   andTaskID taskId: String,
                   completionHandler outerHandler: @escaping (_ success: Bool) -> Void) {
        
        //        let uploadPath = buildPath(withComponents: [kProjects,
        //                                                    projectId,
        //                                                    kComments,
        //                                                    commentId])
        
        let uploadPath = buildPath(withComponents: [kProjects,
                                                    projectId])
        let ref = databaseReference()?.child(uploadPath)
        ref?.runTransactionBlock({ (currentData) -> TransactionResult in
            if var projectData = currentData.value as? [String:AnyObject] {
                guard var comments = projectData[kProjectComments] as! [String:Any]?
                    else {
                        printError("addComment - comments is nil")
                        return TransactionResult.abort()
                }
                comments[aCommentId] = aComment
                projectData[kProjectComments] = comments as AnyObject
                
                guard var tasks = projectData[kProjectTasks] as! [String:Any]?
                    else {
                        printError("addComment - tasks is nil")
                        return TransactionResult.abort()
                }
                guard var currentTask = tasks[taskId] as! [String:Any]?
                    else {
                        printError("addComment - currentTask is nil")
                        return TransactionResult.abort()
                }
                guard var taskComments = currentTask[kTaskComments] as! [String:Any]?
                    else {
                        printError("addComment - taskComments is nil")
                        return TransactionResult.abort()
                }
                
                taskComments[aCommentId] = true
                currentTask[kTaskComments] = taskComments
                tasks[taskId] = currentTask
                tasks[kProjectTasks] = tasks
                projectData[kProjectTasks] = tasks as AnyObject
                currentData.value = projectData
                return TransactionResult.success(withValue: currentData)
            }
            else {
                print("null")
                return TransactionResult.success(withValue: currentData)
            }
            
        }, andCompletionBlock: { (error, success, snapshot) in
            if success
            {
                outerHandler(true)
                print(error ?? snapshot ?? [:])
            }
            else
            {
                printError("AddComment: transaction failed??")
                print(error ?? snapshot ?? [:])
            }
        })
        //        PFCommentFirebaseManager.add(comment: comment,
        //                                     atPath: uploadPath) { (success) in
        //                                        if success
        //                                        {
        //                                            let uploadPath = buildPath(withComponents: [kProjects,
        //                                                                                        projectId,
        //                                                                                        kTasks,
        //                                                                                        taskId,
        //                                                                                        kTaskComments,
        //                                                                                        commentId])
        //                                            setDatabase(value: true,
        //                                                        forPath: uploadPath,
        //                                                        completionHandler: { (success) in
        //                                                            outerHandler(success)
        //                                            })
        //
        //                                        }
        //                                        else
        //                                        {
        //                                            outerHandler(false)
        //                                        }
        //        }
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
