//
//  PRProjectsListViewController.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 23.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//


import UIKit


private let reuseIdentifier = "PFProjectsListCollectionViewCell"

class PFProjectsListViewController: UIViewController{
    
    
    // MARK: - Vars & constants
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var noProjectsLabel: UILabel!
    
    var controllerToPresent = PFProjectDetailsViewController()
    var transitionOptions : [String:Any] = [:]
    var projectAdapter = PFProjectAdapter()
    var searchString: String = ""
    var allData: [String] = []
    var searchData: [String] = []
    var projects: [PFProjectModel]!
    
    // MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupData()
        self.navigationController?.navigationBar.isHidden = true
    }
    

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    // MARK: - Actions
    
    
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
    
    func projectViewController(indexPath:IndexPath) -> UIViewController {
        let projectVC = PFProjectDetailsViewController.storyboardInstance()
        let project = projects[indexPath.item]
        projectVC?.configureWith(projectModel: project)
        return projectVC!
    }
    
    // MARK: - IBActions
    
    
    // MARK: - Handling
    
    
    @objc func handleLongPress(gesture : UILongPressGestureRecognizer!) {
        if gesture.state != .began {
            return
        }
        let p = gesture.location(in: self.collectionView)
        
        if let indexPath = self.collectionView.indexPathForItem(at: p)
        {
            let cell                            = self.collectionView.cellForItem(at: indexPath) as! PFProjectsListCollectionViewCell
            let startingPoint                   = gesture.location(in: self.view)
            let navigationBarHeight: CGFloat    = self.navigationController!.navigationBar.frame.height
            let point                           = CGPoint(x: startingPoint.x,
                                                          y: startingPoint.y + navigationBarHeight + cell.cellHeigth() / 3)
            
            transitionOptions = [kDuration : 0.5,
                                 kStartPoint : point,
                                 kCircleColor : kPFPurpleColor
                ] as [String : Any]
            
            controllerToPresent = projectViewController(indexPath: indexPath) as! PFProjectDetailsViewController
            controllerToPresent.transitioningDelegate    = self
            controllerToPresent.modalPresentationStyle   = .overCurrentContext
            
            self.present(controllerToPresent, animated: true, completion: {
                
            })
            
            
        }
        else
        {            print("couldn't find index path")
        }
    }
}


// MARK: - Data Source


extension PFProjectsListViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let slideMenuController = self.slideMenuController() as! PFSlideMenuController
//        slideMenuController.changeViewController(.tasks)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell    = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                         for: indexPath) as! PFProjectsListCollectionViewCell
        
        let project = searchData[indexPath.item]
        cell.setupCell(withLabel: project)
        let recogniser = UILongPressGestureRecognizer(target: self,
                                                      action: #selector(self.handleLongPress))
        recogniser.minimumPressDuration = CFTimeInterval(0.5)
        cell.addGestureRecognizer(recogniser)
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
        return false
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

extension PFProjectsListViewController: UIViewControllerTransitioningDelegate {
    
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if presented  is PFProjectDetailsViewController {
            let transition = PFTransitionHelper.setCustomOptions(options:transitionOptions)
            transition.transitionMode = .present
            return transition
        }
        return nil
    }
    
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        let transition = PFTransitionHelper.setCustomOptions(options:transitionOptions)
        transition.transitionMode = .dismiss
        dismissed.view.backgroundColor = UIColor.clear
        return transition
    }
}
