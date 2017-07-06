//
//  PRProjectsListViewController.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 23.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//


import UIKit
import PeekPop


private let reuseIdentifier = "PFProjectsListCollectionViewCell"

class PFProjectsListViewController: UIViewController {
    
    
    // MARK: - Vars & constants
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noProjectsLabel: UILabel!
    
    var projectAdapter = PFProjectAdapter()
    var searchString: String = ""
    var allData: [String] = []
    var searchData: [String] = []
    var peekPop: PeekPop? 
    var projects: [PFProjectModel]!
    
    // MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupUI() {
        peekPop = PeekPop(viewController: self)
        peekPop?.registerForPreviewingWithDelegate(self, sourceView: collectionView)
    }
    
    func setupData() {
        projectAdapter.fetchProjects { (projects) in
            self.projects = projects
            self.allData = projects.map({ (project) -> String in
                return project.name!
            })
            self.searchData = self.allData
            self.noProjectsLabel.isHidden = !(self.searchData.count < 1)
            self.collectionView.reloadData()
        }
    }
    
    static func storyboardInstance() -> PFProjectsListViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? PFProjectsListViewController
    }
    
    func signOut()
    {
        
        PFAuthAdapter.signOut { (success) in
            if success
            {
                let appdelegate = UIApplication.shared.delegate as! AppDelegate
                appdelegate.createRootController()
                
                UserDefaults.standard.setValue(false,
                                               forKey: kIsSignedIn)
                
            }
            else
            {
                print("not succesful sign out")
            }
        }
    }
    
    
    // MARK: - Actions
    
    
    @IBAction func hideKeyBoardSwipeDidSwope(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
}


// MARK: - PeekPopPreviewingDelegate


extension PFProjectsListViewController: PeekPopPreviewingDelegate {
    
    func previewingContext(_ previewingContext: PreviewingContext,
                           viewControllerForLocation location: CGPoint) -> UIViewController? {
        if let indexPath = collectionView.indexPathForItem(at: location),
            let cellAttributes = collectionView.layoutAttributesForItem(at: indexPath) {
            previewingContext.sourceRect = cellAttributes.frame
            return projectViewControllerFor(indexPath)
        }
        return nil
    }
    
    func previewingContext(_ previewingContext: PreviewingContext,
                           commitViewController viewControllerToCommit: UIViewController) {
        present(viewControllerToCommit, animated: true, completion: nil)
    }

    
    func projectViewControllerFor(_ indexPath: IndexPath) -> UIViewController {
        let projectVC = PFProjectDetailsViewController()
        let project = projects[indexPath.item]
        projectVC.configureWith(projectModel: project)
        return projectVC
    }

    
}


// MARK: - Data Source


extension PFProjectsListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell    = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                         for: indexPath) as! PFProjectsListCollectionViewCell
        
        let project = searchData[indexPath.item]
        cell.addBorderView(width: CGFloat(1.0),
                           color: kPFPurpleColor.cgColor)
        cell.setupCell(withLabel: project)
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return searchData.count
    }
    
}


// MARK: - Delegate Flow Layout


extension PFProjectsListViewController: UICollectionViewDelegateFlowLayout {
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width/3.8
        return CGSize(width: width,
                      height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return CGFloat(15)
    }
    
}


// MARK: - Gesture Recognizer


extension PFProjectsListViewController:UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}


// MARK: - Text Field Delegate


extension PFProjectsListViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        
        if string.isEmpty
        {
            searchString = String(searchString.characters.dropLast())
        }
        else
        {
            searchString = textField.text!+string
        }
        print(searchString)
        let predicate = NSPredicate(format: "SELF CONTAINS[cd] %@", searchString)
        let arr = (allData as NSArray).filtered(using: predicate)
        
        if arr.count > 0
        {
            searchData.removeAll(keepingCapacity: true)
            searchData = arr as! [String]
        }
        else
        {
            searchData = []
            if searchString.isEmpty
            {
                searchData = allData
            }
            
        }
        noProjectsLabel.isHidden = !(searchData.count < 1)
        collectionView.reloadData()
        return true
    }
    
}

