//
//  PFSlideMenuController.swift
//  TaskTracker
//
//  Created by Valeriy Jefimov on 03.07.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import UIKit
import SideMenuController
//import SlideMenuControllerSwift


class PFSlideMenuController: SideMenuController  {
    
    
    // MARK: - Vars & constants

    
    var rightSideController: PFRightSlideMenuController?
    var taskListController:PFTasksViewController?
    var projectListController:PFProjectsListViewController?
    
    
    // MARK: - LifeCycle
    
    
    public convenience init(mainViewController: UIViewController){
        self.init()
        
        rightSideController = PFRightSlideMenuController.storyboardInstance()
        if mainViewController is PFProjectsListViewController {
            self.projectListController = mainViewController as? PFProjectsListViewController
        }
         taskListController = PFTasksViewController.storyboardInstance()

      self.embed(centerViewController: mainViewController)
     //   self.embed(centerViewController: taskListController!)
        self.embed(sideViewController: rightSideController!)


        
        setupNavigationBar()
    }
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    // MARK: - NavigationBar
    
    
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
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        
     
    }
    
    @objc func hamburgerDidPress(_ : Any)  {
    

    }
}

extension PFSlideMenuController : RightMenuProtocol {
    func changeViewController(_ menu: RightMenu) {
        switch menu {
        case .projects:
            self.navigationController?.navigationBar.topItem?.title = "Projects"
            self.navigationController?.navigationBar.isHidden = true
            break
        case .tasks:
            self.navigationController?.navigationBar.topItem?.title = "Tasks"
            self.navigationController?.navigationBar.isHidden = false
            break
            
        case .chats:
            self.navigationController?.navigationBar.topItem?.title = "Chats"
            break
            
        default:
            break
        }
    }
    
    
}

