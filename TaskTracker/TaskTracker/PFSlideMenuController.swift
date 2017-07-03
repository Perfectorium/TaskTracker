//
//  PFSlideMenuController.swift
//  TaskTracker
//
//  Created by Valeriy Jefimov on 03.07.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift




class PFSlideMenuController : SlideMenuController {
    
    class func newRigthController(with home:UIViewController) -> PFSlideMenuController {
      
        let right  = PFRightSlideMenuController.storyboardInstance()
        //Setup()
        let controller = PFSlideMenuController(mainViewController: home, rightMenuViewController: right!)
        return controller
    }
}

extension PFSlideMenuController : RightMenuProtocol {
    func changeViewController(_ menu: RightMenu) {
        
    }

    
}

