//
//  PFLeftTableViewCell.swift
//  SlideMenuControllerSwift
//
//  Created by Yuji Hato on 1/22/15.
//  Copyright (c) 2015 Yuji Hato. All rights reserved.
//
import UIKit

let kHeigthDevider = 10 as CGFloat

open class PFRightTableViewCell : UITableViewCell {
    
    
     // MARK: - Vars & constants
    
    @IBOutlet weak var menuLabel: UILabel!
    
    class var identifier: String { return String.className(self) }

    class func heigth() -> CGFloat {
        let heigth = UIScreen.main.bounds.size.height
        return heigth / kHeigthDevider
       // return 60
    }
    
    open func setData(_ data: Any?) {
        
        if let menuText = data as? String {
            self.menuLabel?.text = menuText
        }
    }
    

}
