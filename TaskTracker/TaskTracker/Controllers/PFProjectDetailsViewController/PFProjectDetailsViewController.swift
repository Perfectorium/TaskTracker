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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        // Do any additional setup after loading the view.
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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
