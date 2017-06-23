//
//  AccountManager.swift
//  DynamicLinkTest
//
//  Created by Alex Tsonev on 22.06.17.
//  Copyright © 2017 Alex Tsonev. All rights reserved.
//

import Foundation

protocol PFAccountDelegate {
    
    func fetchValue(forKey aKey: String,
                    completionHandler: @escaping (_ value:String) -> Void)
    
    func set(value aValue:String,
             forKey aKey: String,
             completionHandler outerHandler: @escaping (_ success:Bool) -> Void)
}


class PFAccountAdapter {
    
    var delegate = PFAccountManager()
    
    
    //MARK: - Getters
    
    
    func getRole(completionHandler outerHandler: @escaping (_ role:String) -> Void) {
        let coreData = false
        
        if (coreData)
        {
            //CoreData fetching
        }
        else
        {
            delegate.fetchValue(forKey: kRole,
                                completionHandler: { (role) in
                                    outerHandler(role)
            })
        }
    }
    
    func getName(completionHandler outerHandler: @escaping (_ name:String) -> Void) {
        let coreData = false
        
        if (coreData)
        {
            //CoreData fetching
        }
        else
        {
            delegate.fetchValue(forKey: kName,
                                completionHandler: { (name) in
                                    outerHandler(name)
            })
        }
    }
    
    
    //MARK: - Setters
    
    
    func set(name: String,
             completionHandler outerHandler: @escaping (_ name: Bool) -> Void) {
        let coreData = false
        
        if (coreData)
        {
            //CoreData setting
        }
        else
        {
            delegate.set(value: name,
                         forKey: kName,
                         completionHandler: { (success) in
                            
                            outerHandler(success)
            })
        }
    }
    
    func set(password: String,
             completionHandler outerHandler: @escaping (_ name: Bool) -> Void) {
        let coreData = false
        
        if (coreData)
        {
            //CoreData setting
        }
        else
        {
            delegate.set(value: password,
                         forKey: kPassword,
                         completionHandler: { (success) in
                            
                            outerHandler(success)
            })
        }
    }
    
}
