//
//  PFCommentModel+Converter.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 30.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import Foundation

extension PFCommentModel {
    
    static func convertToDictionary(comment: PFCommentModel) -> (info: [String:Any], id: String, commentFiles: [[String:Any]]) {
        
        guard let commentId = comment.commentId,
            let authorId = comment.author?.userId
            else {
                print("PFCommentModel+Converter: convertToDictionary - commentId or authorId is nil")
                return ([:],"",[])
        }
        var files: [[String:Any]]? = nil
        var filesIDs:[String:Bool]? = nil
        if let _ = comment.files {
            files = []
            filesIDs = [:]
            for file in comment.files! {
                let fileModel = file as! PFFileModel
                let fileTuple = PFFileModel.convertToDictionary(file: fileModel)
                files?.append(fileTuple.info)
                filesIDs?[fileTuple.id] = true
            }
        }
        let commentToUpload = [kCommentAuthor:  authorId,
                               kCommentDate:    comment.date,
                               kCommentText:    comment.text,
                               kCommentTimeToAdd: comment.timeToAdd,
                               kCommentFiles:   filesIDs
            ] as [String : Any]
        
        guard files != nil
            else {
                return (commentToUpload, commentId, [])
        }
        return (commentToUpload, commentId, files!)
    }
    
}
