//
//  PFProjectDetailsViewController.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 06.07.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import UIKit

class PFProjectDetailsViewController: UIViewController {

    
    // MARK: - Outlets
    
    @IBOutlet weak var projectAvatarImageView: UIImageView!
    @IBOutlet weak var projectNameLabel: UILabel!
    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var clientLabel: UILabel!
    @IBOutlet weak var estimatedTimeLabel: UILabel!
    
    
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
        projectNameLabel.text = projectModel.name
        textView.text = projectModel.descriptionText ?? ""
        estimatedTimeLabel.text = projectModel.totatEstimated
        spentTime = projectModel.totalSpent
        clientLabel.text = projectModel.client
    }
    
    
    // MARK: - Logo masking
    
    
    private func maskProjectAvatarWith(image:UIImage) {
        let projectMask = #imageLiteral(resourceName: "romb black@1x-1")
        projectAvatarImageView.image = image
        projectAvatarImageView.mask = UIImageView(image: projectMask)
        projectAvatarImageView.mask?.frame = projectAvatarImageView.bounds
    }
    
    
    // MARK: - IBActions
    
    
    @IBAction func BackButtonDidPress(_ sender: UIButton) {
        sender.blink(scale: 0.98)
        self.view.backgroundColor = UIColor.clear
        self.dismiss(animated: true) { 
            
        }
    }

}
