//
//  PFFileManager.swift
//  TaskTracker
//
//  Created by Valeriy Jefimov on 29.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import UIKit

class PFFileManager {
    
    
    //MARK: - FileManager
    
    
    func removeFile(itemName:String, fileExtension: String) {
        let fileManager         = FileManager.default
        let nsDocumentDirectory = FileManager.SearchPathDirectory.documentDirectory
        let nsUserDomainMask    = FileManager.SearchPathDomainMask.userDomainMask
        let paths               = NSSearchPathForDirectoriesInDomains(nsDocumentDirectory,
                                                                      nsUserDomainMask,
                                                                      true)
        guard let dirPath       = paths.first else {
            return
        }
        let filePath            = "\(dirPath)/\(itemName).\(fileExtension)"
        do
        {
            try fileManager.removeItem(atPath: filePath)
        }
        catch let error as NSError
        {
            print(error.debugDescription)
        }
    }
    
    func saveFile(image:UIImage, name:String) -> Bool {
        //Remove old image
        removeFile(itemName: name,
                    fileExtension: "png")
        
        let documentsDirectoryURL = try! FileManager().url(for: .documentDirectory,
                                                           in: .userDomainMask,
                                                           appropriateFor: nil,
                                                           create: true)
        let fileURL = documentsDirectoryURL.appendingPathComponent("avatar.png")
        
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try UIImagePNGRepresentation(image)!.write(to: fileURL)
                print("Image Added Successfully")
                return true
            } catch {
                print(error)
            }
        } else {
            print("Image Not Added")
            return false
        }
        return true
    }

}
