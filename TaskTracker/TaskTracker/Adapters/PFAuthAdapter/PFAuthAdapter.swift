//
//  AuthManager.swift
//  DynamicLinkTest
//
//  Created by Alex Tsonev on 20.06.17.
//  Copyright © 2017 Alex Tsonev. All rights reserved.
//

import Foundation

class PFAuthAdapter {
    
    // Returns array of parameters from URL
    static func getQueryParameters(url: String) -> [String]? {
        
        let fullParams = url.components(separatedBy: "/")
        let params = fullParams[3].components(separatedBy: "&")
        return params
    }
    
    // Registration URL parsing
    class func passActivityURL(_ url: URL) {                // Check APPDELEGATE
        
        let urlString = url.absoluteString
        guard let params = PFAuthAdapter.getQueryParameters(url: urlString) else {
            print()
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
    
    
    class func registration(password: String,
                      completionHandler outerHandler: @escaping (_ success:Bool) -> Void) {
        
        guard var dict = UserDefaults.standard.object(forKey: kParametersKey) as! [String: Any]? else {
            print("PFAuthAdapter - registration: parameters is nil")
            return
        }
        guard let email = dict[kEmail] as! String?
            else {
                print("PFAuthAdapter - registration: email is nil")
                return
        }
        PFAuthFirebaseManager.registration(withEmail: email,
                                       password: password) { (success) in
                                        if success
                                        {
                                            outerHandler(true)
                                            UserDefaults.standard.set(true, forKey: kIsRegistered)
                                            UserDefaults.standard.set(true, forKey: kIsSignedIn)
                                        }
                                        else
                                        {
                                            outerHandler(false)
                                        }
        }
    }
    
    class func signIn(withEmail email: String,
                password: String,
                completionHandler outerHandler: @escaping (_ success:Bool) -> Void) {
        
        var dict: [String:Any] = [:]
        dict[kEmail] = email
        dict[kPassword] = password
        PFAuthFirebaseManager.signIn(withEmail: email,
                                 password: password) { (success) in
                                    if success
                                    {
                                        UserDefaults.standard.set(true, forKey: kIsSignedIn)
                                        outerHandler(success)
                                        return
                                    }
                                    outerHandler(success)
        }
    }
    
    class func signOut(completionHandler outerHandler: @escaping (_ success:Bool) -> Void) {
        
        if !(PFAuthFirebaseManager.signOut())
        {
            print("PFAuthAdapter - signOut: error")
            outerHandler(false)
            return
        }
        print("Succecful signed out")
        UserDefaults.standard.removeObject(forKey: kIsSignedIn)
        outerHandler(true)
    }
    
}
