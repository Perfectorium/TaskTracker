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
        let controller = PFSlideMenuController(mainViewController: home, rightMenuViewController: right!)
        right?.delegate = controller
        controller.setupUI()
         return controller
    }
    
    func setupUI()  {
        SlideMenuOptions.contentViewScale = 1
        
    }    
}

extension PFSlideMenuController : RightMenuProtocol {
    func changeViewController(_ menu: RightMenu) {
        
    }

    
}

