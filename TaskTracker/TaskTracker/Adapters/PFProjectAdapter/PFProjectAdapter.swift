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
    }
    
    
    // MARK: - Observers
    
    
    func createObserverForChildAdded() {
    
        let path = PFFirebaseManager.buildPath(withComponents: [])
        PFFirebaseManager.createObserver(of: .childAdded,
                                         path: path) { (success, snap) in
                                            if success
                                            {
                                            }
        }
    }
    
    
}
