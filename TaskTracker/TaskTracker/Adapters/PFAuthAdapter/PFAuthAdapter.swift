//
//  AuthManager.swift
//  DynamicLinkTest
//
//  Created by Alex Tsonev on 20.06.17.
//  Copyright © 2017 Alex Tsonev. All rights reserved.
//

import Foundation


protocol APIAuthDelegate {
    func signIn(aDict: [String:Any],
                completionHandler: @escaping (_ success:Bool) -> Void)
    
    func signOut() -> Bool
    
    func registration(aDict: [String:Any],
                      completionHandler: @escaping (_ success:Bool) -> Void)
}



class PFAuthAdapter {
    
    var delegate = PFAuthManager()
    
    
    // MARK: - Authentication
    
    
    func registration(password: String,
                      completionHandler outerHandler: @escaping (_ success:Bool) -> Void) {
        
        guard var dict = UserDefaults.standard.object(forKey: kParametersKey) as! [String: Any]? else {
            return
        }
        dict[kPassword] = password

        delegate.registration(aDict: dict) { (success) in
            if (success)
            {
                outerHandler(true)
                UserDefaults.standard.set(true, forKey: kIsRegistered)
            }
            else
            {
                outerHandler(false)
            }
        }
        
    }
    
    func signIn(withEmail email: String,
                password: String,
                completionHandler outerHandler: @escaping (_ success:Bool) -> Void) {
        
        var dict: [String: Any] = [:]
        dict[kEmail] = email
        dict[kPassword] = password
        delegate.signIn(aDict: dict) { (success) in
            if success {
                UserDefaults.standard.set(true, forKey: kIsSignedIn)
                outerHandler(success)
                return
            }
            outerHandler(success)
        }
    }
    
    func signOut(completionHandler outerHandler: @escaping (_ success:Bool) -> Void) {
        
        if !(delegate.signOut())
        {
            print("Signed out with error")
            outerHandler(false)
            return
        }
        print("Succecful signed out")
        UserDefaults.standard.removeObject(forKey: kIsSignedIn)
        outerHandler(true)
    }
    
}
