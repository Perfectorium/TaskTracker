//
//  PFTasksViewController.swift
//  TaskTracker
//
//  Created by Valeriy Jefimov on 10.07.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import UIKit

class PFTasksViewController: UIViewController {
    
    static fileprivate let kTableViewCellReuseIdentifier = "PFTasksTableViewCell"

    
     // MARK: - Vars & constants
    
    
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(PFTasksTableViewCell.self,
                                forCellReuseIdentifier: PFTasksViewController.kTableViewCellReuseIdentifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    static func storyboardInstance() -> PFTasksViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        let controller = storyboard.instantiateInitialViewController() as? PFTasksViewController
        controller?.view.backgroundColor = UIColor.clear
        return controller
    }
    
}

extension PFTasksViewController:UITableViewDataSource, UITableViewDelegate {
    
     func tableView(_ tableView: UITableView,
                            numberOfRowsInSection section: Int) -> Int {
        //guard let posts =  PFCoreDataManager.shared.fetchedResultsController.fetchedObjects else { return 0 }
        return 10
    }
    
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
     func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PFTasksViewController.kTableViewCellReuseIdentifier, for: indexPath) as! PFTasksTableViewCell
        
//        if traitCollection.forceTouchCapability == .available {
//            registerForPreviewing(with: cell, sourceView: cell.seelinkButton)
//        }
//        let post = PFCoreDataManager.shared.fetchedResultsController.fetchedObjects?[indexPath.row]
//        cell.setupCellWith(post: post!) { (suc) in
//            self.view.layoutSubviews()
//        }
  
        
        return cell
    }
    
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}
