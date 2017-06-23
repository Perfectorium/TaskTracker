//
//  FIRAccountAdapter.swift
//  DynamicLinkTest
//
//  Created by Alex Tsonev on 22.06.17.
//  Copyright © 2017 Alex Tsonev. All rights reserved.
//

import Foundation
import FirebaseDatabase


class PFAccountManager {
    
    class func downloadMainInfo(completionHandler: @escaping (_ success:Bool,
                                                              _ userInfo: [String:Any]) -> Void) {
        
        let ref = Database.database().reference()
        let targetReference = ref.child("\(testAdminID)/users/\(testUserID)/mainInfo/")
    
     
        targetReference.observeSingleEvent(of: .value, with: { (snapshot) in
            if let userDict = snapshot.value as? [String:Any] {
                completionHandler(true, userDict)
            }
        })
        { (error) in
            print(error)
            completionHandler(false,[:])
        }
    }
}


extension PFAccountManager: PFAccountDelegate {
    
    func fetchValue(forKey aKey: String,
                    completionHandler: @escaping (_ value:String) -> Void){
        
        PFAccountManager.downloadMainInfo() { (success, dict) in
            if (success)
            {
                let value = dict[aKey] as? String ?? "undefined key"
                completionHandler(value)
            }
        }
    }
    
    func set(value aValue:String,
             forKey aKey: String,
             completionHandler outerHandler: @escaping (_ success:Bool) -> Void) {
        
        let ref = Database.database().reference()
        let targetReference = ref.child("\(testAdminID)/users/\(testUserID)/mainInfo/\(aKey)/")
        targetReference.setValue(aValue) { (error, ref) in
            if error != nil
            {
                print(error ?? "")
                outerHandler(false)
            }
            else
            {
                outerHandler(true)
            }
        }
        
    }
    
}


