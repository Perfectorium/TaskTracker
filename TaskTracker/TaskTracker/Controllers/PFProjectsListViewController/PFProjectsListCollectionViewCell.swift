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
    
    func cellHeigth() -> CGFloat {
        return self.frame.height
    }
    
    func setupCell(withProject project: PFProjectModel)  {
        projectLabel.text = project.name!
    }
    
    func setupCell(withLabel label: String)  {
        projectLabel.text = label
        self.addBorderView(width: CGFloat(1.0),
                           color: kPFPurpleColor.cgColor)
    }
}
