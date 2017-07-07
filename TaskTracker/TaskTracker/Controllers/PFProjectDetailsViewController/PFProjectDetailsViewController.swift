//
//  PFProjectDetailsViewController.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 06.07.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import UIKit

class PFProjectDetailsViewController: UIViewController {

    
    // MARK: - Properties
    
    var name: String?
    var projectDescription: String?
    var estimetedTime: String?
    var spentTime: String?
    var client: String?
    
    static func storyboardInstance() -> PFProjectDetailsViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as? PFProjectDetailsViewController
        controller?.view.backgroundColor = UIColor.clear
        return controller
    }
    
      // MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureWith(projectModel: PFProjectModel) {
        name = projectModel.name
        projectDescription = projectModel.descriptionText
        estimetedTime = projectModel.totatEstimated
        spentTime = projectModel.totalSpent
        client = projectModel.client
    }
    
    
  // MARK: - IBActions
    
    
    @IBAction func BackButtonDidPress(_ sender: UIButton) {
        sender.blink(scale: 0.98)
        self.view.backgroundColor = UIColor.clear
        self.dismiss(animated: true) { 
            
        }
    }

}
