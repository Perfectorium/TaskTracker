//
//  PFProjectDetailsTableViewCell.swift
//  TaskTracker
//
//  Created by Алла on 08.08.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import UIKit

class PFProjectDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setCell(_ text: String){
        self.label.text = text
    }

}
