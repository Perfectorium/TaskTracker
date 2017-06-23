//
//  PRProjectsListViewController.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 23.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import UIKit

class PRProjectsListViewController: UIViewController {

    static func storyboardInstance() -> LoginViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? LoginViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
