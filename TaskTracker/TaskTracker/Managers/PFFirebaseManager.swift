//
//  PFFirebaseDBManager.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 27.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import Foundation
import FirebaseDatabase
import FirebaseAuth

class PFFirebaseManager {
    
    
    //MARK: - LifeCycle
    
    
    class func buildPath(withComponents components:[String]) -> String {
        var resultPath = ""
        for word in components {
            resultPath.append(word)
            resultPath.append("/")
        }
        return resultPath
    }
    
    
    // MARK: - References
    
    
    static func adminID () -> String? {
        
        guard let parameters = UserDefaults.standard.value(forKey: kParametersKey) as! [String:Any]?
            else {
                return nil
        }
        guard let id = parameters[kAdminID] as! String?             // Fix AdminID source
            else {
                return nil
        }
        return id
    }
    
    static func ownerID () -> String? {
        
        guard let parameters = UserDefaults.standard.value(forKey: kParametersKey) as! [String:Any]?
            else {
                return nil
        }
        guard let id = parameters[kUserID] as! String?             // Fix ownerID source
            else {
                return nil
        }
        return id
    }
    
    static func databaseReference() -> DatabaseReference? {
        let reference = Database.database().reference()
        guard let id = adminID()
            else {
                printError("adminID is nil")
                return nil
        }
        return reference.child(id)
    }
    
    
    // MARK: - Database Management
    
    
    class func fetchDatabase(withPath childPath: String,
                             completionHandler: @escaping (_ result: Any?) -> Void) {
        guard let reference = databaseReference()
            else {
                printError("fetchDatabase error: DBReference is nil")
                return
        }
        let targetReference = reference.child(childPath)
        targetReference.observeSingleEvent(of: .value, with: { (snapshot) in
            print(snapshot)
            if let userDict = snapshot.value as? [String:Any] {
                completionHandler(userDict)
            }
            print("suck")
        })
        { (error) in
            self.printError("fetchDatabaseError: \(error)")
            completionHandler(nil)
        }
    }
    
    class func setDatabase(value: Any, //[String:Any],
        forPath childPath: String,
        completionHandler outerHandler: @escaping (_ success:Bool) -> Void) {
        
        guard let reference = databaseReference()
            else {
                printError("fetchDatabase error: DBReference is nil")
                return
        }
        let targetReference = reference.child(childPath)
        targetReference.setValue(value) { (error, ref) in
            if error != nil
            {
                self.printError("setDatabaseError: \(String(describing: error))")
                outerHandler(false)
            }
            else
            {
                outerHandler(true)
            }
        }
        
    }
    
    
    // MARK: - Helpers
    
    
    class func printError(_ error: String) {
        print("\(String.init(describing: self)) - \(String(describing: error))")
    }
    
    
}

