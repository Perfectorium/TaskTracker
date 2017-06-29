//
//  PFProjectsListCollectionViewCell.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 26.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import UIKit

class PFProjectsListCollectionViewCell: UICollectionViewCell {
    
    //MARK: - Vars & Constants
    
    
    @IBOutlet weak var projectLabel: UILabel!
    
    
    
    //MARK: - Actions
    
    
    func setupCell(withLabel labelText: String, color: UIColor)  {
        projectLabel.text = labelText
        self.backgroundColor = color
        self.cornerRadius = 15.0
        
    }
}
