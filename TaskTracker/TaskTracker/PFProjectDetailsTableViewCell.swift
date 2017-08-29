//
//  PFProjectDetailsTableViewCell.swift
//  TaskTracker
//
//  Created by Алла on 21.08.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import UIKit

class PFProjectDetailsTableViewCell: UITableViewCell {


    @IBOutlet weak var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setUpCell(_ text: String){
       self.label.text = text
        
    }

}
