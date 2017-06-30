//
//  PFCommentFirebaseManager.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 30.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import Foundation

class PFCommentFirebaseManager: PFFirebaseManager {
    
    static func add(comment: [String:Any],
                    atPath: String,
                    completionHandler outerHandler: @escaping (_ success: Bool) -> Void) {
        
        setDatabase(value: comment,
                    forPath: atPath) { (success) in
                        outerHandler(success)
        }
    }
    
}
