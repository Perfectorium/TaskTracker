//
//  PFTaskFirebaseManager.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 29.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import Foundation

class PFTaskFirebaseManager: PFFirebaseManager {
    
    class func addTask(task: PFTaskModel,
                       projectID: String,
                       withcompletionHandler outerHandler: @escaping (_ success: Bool) -> Void) {
        
        let taskMainInfo = [kTaskAuthor:        task.authorId,
                            kTaskDescription:   task.descriptionText,
                            kTaskName:          task.name,
                            kTaskEstimatedTime: task.estimatedTime,
                            kTaskStartTime:     task.startTime,
                            kTaskEndTime:       task.endTime,
                            kTaskStatus:        task.status,
                            kTaskType:          task.type,
                            kTaskPriority:      task.priority]
        let taskFiles = fetchFiles(fromModel: task)
        let taskUsers = fetchUsers(fromModel: task)
        
        
        let taskToUpload = [kMainInfo:  taskMainInfo,
                            kTaskFiles: taskFiles,
                            kTaskUsers: taskUsers] as [String : Any]
        
        let uploadPath = buildPath(withComponents: [kProjects,
                                                    projectID,
                                                    kTasks])
        setDatabase(value: taskToUpload,
                    forPath: uploadPath) { (success) in
                        
        }
    }
    
    
    // MARK: - Helpers
    
    
    private class func fetchFiles(fromModel task: PFTaskModel) -> [String:Any] {
        
        var taskFiles: [String:[String:String]] = [:]
        
        if task.files != nil
        {
            for file in task.files! {
                let fileModel = file as! PFFileModel
                guard
                    let url = fileModel.url,
                    let fileId = fileModel.fileId,
                    let type = fileModel.type
                    else {
                        printError("addTaskError - file`s URL or type is nil")
                        return [:]
                }
                taskFiles[fileId] = [kFileType: type,
                                     kFileURL:  url]
            }
        }
        return taskFiles
    }
    
    private class func fetchUsers(fromModel task: PFTaskModel) -> [String] {
        
        var taskUsers: [String] = []
        guard let users = task.users
            else {
                printError("addTaskError - users is nil")
                return []
        }
        
        for user in users {
            let userModel = user as! PFUserModel
            guard let id = userModel.userId
                else {
                    printError("addTaskError - userID is nil")
                    return []
            }
            taskUsers.append(id)
        }
        
        return taskUsers
    }
    
}
