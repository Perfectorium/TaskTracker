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
    
    @IBOutlet weak var projectDetailsTableView: UITableView!
    @IBOutlet weak var projectAvatarImageView: UIImageView!
    

    
    @IBOutlet weak var closeButtonOutlet: UIButton!


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
      projectDetailsTableView.delegate = self
        projectDetailsTableView.dataSource = self
        maskProjectAvatarWith(image: #imageLiteral(resourceName: "romb+logo"))
    }


    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var projectDetailsArray: [String] = []
    
    func configureWith(projectModel: PFProjectModel) {
        
        projectDetailsArray.append(projectModel.name!)
        projectDetailsArray.append(projectModel.descriptionText!)
        projectDetailsArray.append(projectModel.totatEstimated!)
        projectDetailsArray.append(projectModel.client!)
    }
    
    
    // MARK: - Logo masking
    
    
    private func maskProjectAvatarWith(image:UIImage) {
        
        projectAvatarImageView.image = image
//        let projectMask = #imageLiteral(resourceName: "romb black@1x-1")
//        projectAvatarImageView.image = image
//        projectAvatarImageView.mask = UIImageView(image: projectMask)
//        projectAvatarImageView.mask?.frame = projectAvatarImageView.bounds
    }
    
    
    // MARK: - IBActions
    
    
    @IBAction func closeButton(_ sender: UIButton) {
      
        self.dismiss(animated: true, completion: nil)
        
        
    }

}

//MARK: - Data Source

extension PFProjectDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return projectDetailsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PFProjectDetailsTableViewCell", for: indexPath) as! PFProjectDetailsTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.none
        if  let textPerCell = projectDetailsArray[indexPath.item] as? String {
                        cell.setCell(textPerCell)
    }
    
        
        return cell
    }
}
