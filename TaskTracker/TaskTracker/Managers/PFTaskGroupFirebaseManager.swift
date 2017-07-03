//
//  PFTaskGroupFirebaseManager.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 03.07.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import Foundation

class PFTaskGroupFirebaseManager: PFFirebaseManager {
    
    class func getTaskGroups(completionHandler: @escaping (_ success:Bool, _ groupInfo: [String:Any]) -> Void) {
        
        guard let userID = ownerID()
            else {
                printError("getTaskGroupInfo: userID is nil")
                completionHandler(false,[:])
                return
        }
        let path = buildPath(withComponents: [kUsers, userID, kTaskGroups])
        fetchDatabase(withPath: path) { (result) in
            guard  let response = result as! [String:Any]?
                else {
                    printError("downloadUserInfoError: result is nil")
                    completionHandler(false, [:])
                    return
            }
            completionHandler(true, response)
        }
    }
    
    class func getTaskGroupInfo(groupID: String,
                                completionHandler: @escaping (_ success:Bool, _ groupInfo: [String:Any]) -> Void) {

        getTaskGroups() { (success, groups) in
            if success
            {
                guard let group = groups[groupID] as! [String:Any]?
                    else {
                        printError("getTaskGroupInfo")
                        completionHandler(false, [:])
                        return
                }
                completionHandler(true, group)
            }
            else
            {
                completionHandler(false,[:])
            }
        }
    }
    
    class func getTasks(fromGroupWithID groupID: String,
                        completionHandler: @escaping (_ success:Bool, _ groupInfo: [String:Any]) -> Void) {
        
        getTaskGroupInfo(groupID: groupID) { (success, group) in
            if success
            {
                guard let tasks = group[kTaskGroupTasks] as! [String:Any]?
                    else {
                        printError("getTasksFromGroupWithID: tasks is nil")
                        completionHandler(false,[:])
                        return
                }
                completionHandler(true, tasks)
            }
            else
            {
                completionHandler(false,[:])
            }
        }
    }
}
