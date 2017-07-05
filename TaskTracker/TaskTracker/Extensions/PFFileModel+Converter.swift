//
//  PFFileModel+Converter.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 04.07.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import Foundation

extension PFFileModel {
    
    static func convertToDictionary(file: PFFileModel) -> (info: [String:Any], id: String) {
        

        let fileDictionary = [kFileURL: file.url,
                              kFileType: file.type]
        guard let fileID = file.fileId
            else {
                print("PFFileModel + fileID is nil")
                return ([:],"")
        }
        
        return (fileDictionary ?? [:] , fileID)
        
    }
    
}
