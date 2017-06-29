//
//  PFAuthFirebaseManager.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 29.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import Foundation
import FirebaseAuth

class PFAuthFirebaseManager: PFFirebaseManager {
    
    
    // Sign in a user to a firebase project
    class func signIn(withEmail email: String,
                      password: String,
                      completionHandler: @escaping (_ success:Bool) -> Void) {
        
        
        Auth.auth().signIn(withEmail: email,
                           password: password,
                           completion: { (user, error) in
                            if error != nil
                            {
                                self.printError("signInError: \(String(describing: error))")
                                completionHandler(false)
                            }
                            else
                            {
                                completionHandler(true)
                            }
        })
    }
    
    // Creates a user in a firebase project
    class func registration(withEmail email: String,
                            password: String,
                            //infoDictionary: [String:Any],
        completionHandler outerHandler: @escaping (_ success:Bool) -> Void) {
        
        Auth.auth().createUser(withEmail: email,
                               password: password,
                               completion: { (user, error) in
                                if error != nil
                                {
                                    self.printError("registrationError: \(String.init(describing: error))")
                                    outerHandler(false)
                                }
                                else
                                {
                                    outerHandler(true)
                                }
        })
    }
    
    // Sign out a user from Firebase
    class func signOut() -> Bool {
        
        do
        {
            try Auth.auth().signOut()
            return true
        }
        catch
        {
            printError("signOutError")
            return false
        }
    }
    
    // Deletes a user from Firebase Authentication user list
    class func deleteUser(completionHandler: @escaping (_ success:Bool) -> Void) {
        let user = Auth.auth().currentUser
        
        user?.delete { error in
            if let error = error {
                self.printError(error as! String)
                completionHandler(false)
            } else {
                completionHandler(true)
            }
        }
    }

}
