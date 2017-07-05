//
//  File.swift
//  TaskTracker
//
//  Created by Valeriy Jefimov on 04.07.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import Foundation


class PFProjectAdapter {
    
    
    // MARK: - LifeCycle
    
    
    init() {
        createObserverForChildAdded()
        createObserverForChildChanged()
        createObserverForChildRemoved()
    }
    
    
    // MARK: - Observers
    
    
    func createObserverForChildAdded() {
    
        let path = PFFirebaseManager.buildPath(withComponents: [kProjects])
        PFFirebaseManager.createObserver(of: .childAdded,
                                         path: path) { (success, snapshot) in
                                            guard let project = snapshot?.value as! [String:Any]?
                                                else {
                                                    return
                                            }
                                            if success
                                            {
                                                print(project)
                                            }
        }
    }
    
    func createObserverForChildRemoved() {
        let path = PFFirebaseManager.buildPath(withComponents: [kProjects])
        PFFirebaseManager.createObserver(of: .childRemoved,
                                         path: path) { (success, snapshot) in
                                            guard let project = snapshot?.value as! [String:Any]?
                                                else {
                                                    return
                                            }
                                            if success
                                            {
                                                print(project)
                                            }
        }
    }
    
    func createObserverForChildChanged() {
        let path = PFFirebaseManager.buildPath(withComponents: [kProjects])
        PFFirebaseManager.createObserver(of: .childChanged,
                                         path: path) { (success, snapshot) in
                                            guard let project = snapshot?.value as! [String:Any]?
                                                else {
                                                    return
                                            }
                                            if success
                                            {
                                                print(project)
                                            }
        }
    }
    
}
