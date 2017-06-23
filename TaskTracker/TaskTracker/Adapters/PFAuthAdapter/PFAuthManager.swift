//
//  FirebaseManager.swift
//  DynamicLinkTest
//
//  Created by Alex Tsonev on 20.06.17.
//  Copyright © 2017 Alex Tsonev. All rights reserved.
//


import Foundation
import FirebaseDatabase
import FirebaseAuth


class PFAuthManager {
    
    
    let auth = Auth.auth()
    
    
    // MARK:: - User Managing
    
    
    // Creates a user in a Firebase project's DB
    class func createUser(dict: [String : Any],
                          completionHandler: @escaping (_ success:Bool) -> Void)  {
        
        var mainInfo = dict
        let adminId         = mainInfo[kAdminID] as! String
        let userId          = mainInfo[kUserID] as! String
//        mainInfo.removeValue(forKey: kAdminID)
//        mainInfo.removeValue(forKey: kUserID)
        
        let ref             = Database.database().reference()
        let childPath       = "\(adminId)/users/\(userId)/mainInfo/"
        
        ref.child(childPath).setValue(dict) { (error, ref) in
            if error != nil
            {
                print(error ?? "")
                completionHandler(false)
            }
            else
            {
                completionHandler(true)
            }
        }
    }
    
    // Returns array of parameters from URL
    class func getQueryParameters(url: String) -> [String]? {
        
        let fullParams = url.components(separatedBy: "/")
        let params = fullParams[3].components(separatedBy: "&")
        return params
    }
    
    // URL
    class func passActivityURL(_ url: URL) {
        
        let urlString = url.absoluteString
        guard let params = PFAuthManager.getQueryParameters(url: urlString) else {
            return
        }
        
        var dict = [String : Any]()
        for pair in params {
            let pairArr = pair.components(separatedBy: "=")
            dict[pairArr[0]] = pairArr[1]
        }
        
        let defaults = UserDefaults.standard
        defaults.set(dict, forKey: kParametersKey)
    }
    
}

extension PFAuthManager: APIAuthDelegate {
    
    // MARK: - Authentication
    
    
    // Sign in's a user to a firebase project
    func signIn(aDict: [String:Any],
                completionHandler: @escaping (_ success:Bool) -> Void) {
        
        var aDict = aDict
        guard let email = aDict[kEmail] as! String?,
            let password = aDict[kPassword] as! String? else {
                return
        }
        aDict.removeValue(forKey: kPassword)
        self.auth.signIn(withEmail: email,
                    password: password,
                    completion: { (user, error) in
                        if error != nil
                        {
                            print(error ?? "")
                            completionHandler(false)
                        }
                        else
                        {
                            completionHandler(true)
                        }
        })
    }
    
    // Creates a user in a firebase project
    func registration(aDict: [String:Any],
                      completionHandler: @escaping (_ success:Bool) -> Void) {
        
        var dictionary = aDict
        guard let email = dictionary[kEmail] as! String? else {
            return
        }
        guard let password = dictionary[kPassword] as! String? else {
            return
        }
        dictionary.removeValue(forKey: kPassword)
        
        self.auth.createUser(withEmail: email,
                        password: password,
                        completion: { (user, error) in
                            if error != nil
                            {
                                print(error ?? "")
                                completionHandler(false)
                            }
                            else
                            {
                                completionHandler(true)
                                PFAuthManager.createUser(dict: dictionary,
                                                          completionHandler: { (success) in
                                })
                                UserDefaults.standard.set(true, forKey: kIsRegistered)
                            }
        })
    }
    
    func signOut() -> Bool {
        
        do
        {
            try self.auth.signOut()
            return true
        }
        catch
        {
            print("SignOut failed")
            return false
        }
    }
    
    
}
