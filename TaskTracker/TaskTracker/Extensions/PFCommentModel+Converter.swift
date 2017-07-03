//
//  PFCommentModel+Converter.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 30.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import Foundation

extension PFCommentModel {
    
    static func convertToDictionary(comment: PFCommentModel) -> (info: [String:Any], id: String, commentFiles: [String:Any]) {
        
        guard let commentId = comment.commentId,
            let authorId = comment.author?.userId
            else {
                print("PFCommentModel+Converter: convertToDictionary - commentId or authorId is nil")
                return ([:],"",[:])
        }
        let commentFiles = fetchFiles(fromModel: comment)
        let filesIDs = Array(commentFiles.keys)
        let commentToUpload = [kCommentAuthor:  authorId,
                               kCommentDate:    comment.date,
                               kCommentText:    comment.text,
                               kCommentTimeToAdd: comment.timeToAdd,
                               kCommentFiles:   filesIDs
        ] as [String : Any]
        
        
        return (commentToUpload, commentId, commentFiles)
        
    }
    
    private class func fetchFiles(fromModel comment: PFCommentModel) -> [String:Any] {
        
        var commentFiles: [String:[String:String]] = [:]
        
        if comment.files != nil
        {
            for file in comment.files! {
                let fileModel = file as! PFFileModel
                guard
                    let url = fileModel.url,
                    let fileId = fileModel.fileId,
                    let type = fileModel.type
                    else {
                        print("PFCommentModel+Converter: addTaskError - file`s URL, type or ID is nil")
                        return [:]
                }
                commentFiles[fileId] = [kFileType: type,
                                        kFileURL:  url]
            }
        }
        return commentFiles
    }
    
}
