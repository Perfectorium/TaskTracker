//
//  PFTaskModel+Converter.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 30.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import Foundation

// Model Converter
extension PFTaskModel {
    
    static func convertToDictionary(task: PFTaskModel) -> (info: [String:Any], id: String, filesToUpload:[String:Any]) {
        
        guard let taskId = task.taskId
            else {
                print("PFTaskAdapter: addTask - taskID is nil")
                return ([:],"",[:])
        }
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
        let filesIDs = Array(taskFiles.keys)
        let taskToUpload = [kMainInfo:  taskMainInfo,
                            kTaskFiles: filesIDs,
                            kTaskUsers: taskUsers] as [String : Any]
        
        return (taskToUpload, taskId, taskFiles)
        
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
                        print("PFTaskModel+Converter: addTaskError - file`s URL or type is nil")
                        return [:]
                }
                taskFiles[fileId] = [kFileType: type,
                                     kFileURL:  url]
            }
        }
        return taskFiles
    }
    
    private class func fetchUsers(fromModel task: PFTaskModel) -> [String:Any] {
        
        var taskUsers: [String:Any] = [:]
        guard let users = task.users
            else {
                print("PFTaskModel+Converter: addTaskError - users is nil")
                return [:]
        }
        for user in users {
            let userModel = user as! PFUserModel
            guard let id = userModel.userId
                else {
                    print("PFTaskModel+Converter: addTaskError - userID is nil")
                    return [:]
            }
            taskUsers[id] = true
        }
        return taskUsers
    }
}
