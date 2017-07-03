//
//  PFProjectFirebaseManager.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 29.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import Foundation

class PFProjectFirebaseManager: PFFirebaseManager {
    
    
    //MARK: - Getters
    
    
    class func downloadMainInfo(projectID: String,
                                completionHandler: @escaping (_ success:Bool, _ projectInfo: [String:Any]) -> Void) {
        let path = buildPath(withComponents: [kProjects, projectID, kMainInfo])
        fetchDatabase(withPath: path) { (result) in
            guard  let response = result as! [String:Any]?
                else {
                    printError("downloadMainInfoError: result is nil")
                    completionHandler(false, [:])
                    return
            }
            completionHandler(true,response)
        }
    }
    
    
    class func getMain(value: String,
                       withID id: String,
                       completionHandler outerHandler: @escaping (_ value:Any) -> Void) {
        
        let path = buildPath(withComponents: [kProjects,id,kMainInfo,value])
        fetchDatabase(withPath: path) { (result) in
            guard result != nil
                else {
                    printError("getMainValueWithIdError: result is nil")
                    outerHandler(kUndefined)
                    return
            }
            outerHandler(result ?? "")
        }
    }
    
    
    // MARK: - Project related getters
    
    
    class func getAvatar(withID id: String,
                         completionHandler outerHandler: @escaping (_ phone: String) -> Void) {
        
        getMain(value: kProjectAvatarURL,
                withID: id) { (phone) in
                    outerHandler(phone as! String)
        }
    }
    
    class func getClient(withID id: String,
                         completionHandler outerHandler: @escaping (_ phone: String) -> Void) {
        
        getMain(value: kProjectClient,
                withID: id) { (phone) in
                    outerHandler(phone as! String)
        }
    }
    
    class func getDescription(withID id: String,
                              completionHandler outerHandler: @escaping (_ phone: String) -> Void) {
        
        getMain(value: kProjectDescription,
                withID: id) { (phone) in
                    outerHandler(phone as! String)
        }
    }
    
    class func getName(withID id: String,
                       completionHandler outerHandler: @escaping (_ phone: String) -> Void) {
        
        getMain(value: kProjectName,
                withID: id) { (phone) in
                    outerHandler(phone as! String)
        }
    }
    
    class func getSpentTime(withID id: String,
                            completionHandler outerHandler: @escaping (_ phone: String) -> Void) {
        
        getMain(value: kProjectSpentTime,
                withID: id) { (phone) in
                    outerHandler(phone as! String)
        }
    }
    
    class func getTotalEstimatedTime(withID id: String,
                                     completionHandler outerHandler: @escaping (_ phone: String) -> Void) {
        
        getMain(value: kProjectTotalEstimatedTime,
                withID: id) { (phone) in
                    outerHandler(phone as! String)
        }
    }
    
    class func getTasks(withID id: String,
                        completionHandler: @escaping (_ tasks: [String:Any]) -> Void) {
        
        let path = buildPath(withComponents: [kProjects, id, kProjectTasks])
        fetchDatabase(withPath: path) { (result) in
            guard  let response = result as! [String:Any]?
                else {
                    printError("getTasksError: result is nil")
                    completionHandler([:])
                    return
            }
            completionHandler(response)
        }
    }
    
    class func getUsersList(withID id: String,
                            completionHandler: @escaping (_ users: [String]) -> Void) {
        
        let path = buildPath(withComponents: [kProjects, id, kProjectUsers])
        fetchDatabase(withPath: path) { (result) in
            guard  let response = result as! [String]?
                else {
                    printError("getTasksError: result is nil")
                    completionHandler([])
                    return
            }
            completionHandler(response)
        }
    }
    
    
    // MARK: - Setters
    
    
    class func setMain(value: Any,
                       forKey key: String,
                       withID id: String,
                       completionHandler outerHandler: @escaping (_ success: Bool) -> Void) {
        
        let path = buildPath(withComponents: [kProjects,id,kMainInfo,key])
        setDatabase(value: value,
                    forPath: path) { (success) in
                        
                        outerHandler(success)
        }
    }
    
    
    // MARK: - Project related setters
    
    
    class func addTask(task: [String:Any],
                       withID id: String, // PFTaskModel,
                       projectID: String,
                       withCompletionHandler outerHandler: @escaping (_ success: Bool) -> Void) {
        
        PFTaskFirebaseManager.add(task: task,
                                  withID: id,
                                  toProjectID: projectID) { (success) in
                                    outerHandler(success)
        }
        
    }
    
    class func addUser(user: PFUserModel,
                       projectID: String,
                       withCompletionHandler outerHandler: @escaping (_ success: Bool) -> Void) {
        
        guard let userID = user.userId
            else {
                printError("addUserError - userID is nil")
                return
        }
        let path = buildPath(withComponents: [kProjects,projectID,kProjectUsers,userID])
        setDatabase(value: true,
                    forPath: path) { (success) in
                        outerHandler(success)
        }
        
    }
    
    
    
    
}
