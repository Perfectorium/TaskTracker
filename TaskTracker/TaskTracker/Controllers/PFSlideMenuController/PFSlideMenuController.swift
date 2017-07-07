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
    
    
    // MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        setupNavigationBar()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
        setupNavigationBar()
    }
    
    
    // MARK: - Actions
    
    
    class func newRigthController(with home:UIViewController) -> PFSlideMenuController {
        
        let right                       = PFRightSlideMenuController.storyboardInstance()
        let controller                  = PFSlideMenuController(mainViewController: home,
                                                                rightMenuViewController: right!)
        right?.delegate                 = controller
        controller.view.backgroundColor = kPFWhiteColor
        controller.setupUI()
        return controller
    }
    
    func setupUI() {
        
        SlideMenuOptions.contentViewScale = 0.98
        self.opacityView.backgroundColor = kPFWhiteColor
        SlideMenuOptions.rightBezelWidth = 100.0
    }
    
    func setupNavigationBar() {
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        self.navigationController?.navigationBar.shadowImage            = UIImage()
        self.navigationItem.hidesBackButton                             = true
        self.navigationController?.navigationBar.barTintColor           = kPFWhiteColor
        self.navigationController?.navigationBar.isTranslucent          = false
        self.navigationController?.navigationBar.backgroundColor        = kPFWhiteColor
        self.navigationController?.navigationBar.topItem?.title         = "Projects"
        self.navigationController?.navigationBar.titleTextAttributes    = [NSFontAttributeName:kPFFontTitles!,
                                                                        NSForegroundColorAttributeName:kPFBlackColor]
        var image                               = #imageLiteral(resourceName: "Burger menu ")
        image                                   = image.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        let item                                = UIBarButtonItem(image: image,
                                                                  style: .plain,
                                                                  target: self,
                                                                  action: #selector(hamburgerDidPress(_:)))
        item.tintColor                          = kPFPurpleColor
        self.navigationItem.rightBarButtonItem  = item
        self.navigationItem.rightBarButtonItem?.isEnabled = true
    }
    
    @objc func hamburgerDidPress(_ : Any)  {
        if isRightOpen()
        {
            self.closeRight()
        }
        else
        {
            openRight()
        }
    }
}

extension PFSlideMenuController : RightMenuProtocol {
    func changeViewController(_ menu: RightMenu) {
        
    }
    
    
}

