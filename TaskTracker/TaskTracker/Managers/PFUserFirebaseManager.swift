//
//  PFUserFirebaseManager.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 27.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import Foundation

class PFUserFirebaseManager : PFFirebaseManager {

    
    // MARK: - Getters
    
    
    class func downloadMainInfo(userID: String,
                                completionHandler: @escaping (_ success:Bool, _ userInfo: [String:Any]) -> Void) {
        let path = buildPath(withComponents: [kUsers, userID, kMainInfo])
        PFFirebaseManager.fetchDatabase(withPath: path) { (result) in
            guard  let response = result as! [String:Any]?
                else {
                    print("PFAccountAdapter - downloadMainInfoError: result is nil")
                    completionHandler(false, [:])
                    return
            }
            completionHandler(true,response)
        }
    }
    
    
    class func getMain(value: String,
                       withID id: String,
                       completionHandler outerHandler: @escaping (_ value:Any) -> Void) {
        
        let path = buildPath(withComponents: [kUsers,id,kMainInfo,value])
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
    
    
    // MARK: - User related getters
    
    
    class func getName(withID id: String,
                       completionHandler outerHandler: @escaping (_ name:String) -> Void) {
        
        getMain(value: kName,
                withID: id) { (name) in
                    outerHandler(name as! String)
        }
    }
    
    class func getRole(withID id: String,
                       completionHandler outerHandler: @escaping (_ role: String) -> Void) {
        
        getMain(value: kRole,
                withID: id) { (role) in
                    outerHandler(role as! String)
        }
    }
    
    class func getPhone(withID id: String,
                        completionHandler outerHandler: @escaping (_ phone: String) -> Void) {
        
        getMain(value: kPhone,
                withID: id) { (phone) in
                    outerHandler(phone as! String)
        }
    }
    
    class func getAvatarURL(withID id: String, completionHandler outerHandler: @escaping (_ avatarURL:String) -> Void) {
        
        getMain(value: kAvatarURL,
                withID: id) { (avatar) in
                    outerHandler(avatar as! String)
        }
    }
    
    class func getEmail(withID id: String, completionHandler outerHandler: @escaping (_ email:String) -> Void) {
        
        getMain(value: kEmail,
                withID: id) { (email) in
                    outerHandler(email as! String)
        }
    }
    
    class func getProjects(withID id: String,
                           completionHandler outerHandler: @escaping (_ projects:[String]) -> Void) {
        
        getMain(value: kProjects,
                withID: id) { (array) in
                    outerHandler(array as! [String])
        }
    }
    
    class func getWorkingHours(withID id: String,
                               completionHandler outerHandler: @escaping (_ workingHours:[String:Any]) -> Void) {
        
        getMain(value: kWorkingHours,
                withID: id) { (dictionary) in
                    outerHandler(dictionary as! [String:Any])
        }
    }
    
    
    // MARK: - Setters
    
    
    class func set(value: Any,
                   forKey key: String,
                   withID id: String,
                   completionHandler outerHandler: @escaping (_ success: Bool) -> Void) {
        
        let path = buildPath(withComponents: [kUsers,id,key])
        PFFirebaseManager.setDatabase(value: value,
                                      forPath: path) { (success) in
   
                                        outerHandler(success)
        }
    }
    
    class func setMain(value: Any,
                       forKey key: String,
                       withID id: String,
                       completionHandler outerHandler: @escaping (_ success: Bool) -> Void) {
        
        let path = buildPath(withComponents: [kUsers,id,kMainInfo,key])
        PFFirebaseManager.setDatabase(value: value,
                                      forPath: path) { (success) in
                                        
                                        outerHandler(success)
        }
    }
    
    
    // MARK: - User related setters
    
    
    class func set(name: String,
             withID id: String,
             completionHandler outerHandler: @escaping (_ name: Bool) -> Void) {
        
        setMain(value: name,
                forKey: kName,
                withID: id) { (success) in
                    outerHandler(success)
        }
    }
    
    class func set(avatarURL: String,
                   withID id: String,
                   completionHandler outerHandler: @escaping (_ name: Bool) -> Void) {
        
        setMain(value: avatarURL,
                forKey: kAvatarURL,
                withID: id) { (success) in
                    outerHandler(success)
        }
    }
    
    class func set(phone: String,
                   withID id: String,
                   completionHandler outerHandler: @escaping (_ name: Bool) -> Void) {
        
        setMain(value: phone,
                forKey: kPhone,
                withID: id) { (success) in
                    outerHandler(success)
        }
    }    
    
}
