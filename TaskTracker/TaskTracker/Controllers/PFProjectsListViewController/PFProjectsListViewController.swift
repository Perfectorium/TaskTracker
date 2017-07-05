//
//  PRProjectsListViewController.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 23.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//


import UIKit

private let reuseIdentifier = "PFProjectsListCollectionViewCell"

class PFProjectsListViewController: UIViewController, UITextFieldDelegate {
    
    
    // MARK: - Vars & constants
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    static func storyboardInstance() -> PFProjectsListViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? PFProjectsListViewController
    }
    
    
    // MARK: - LifeCycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        //let project = PFProjectAdapter()
        //let tasks = PFTaskAdapter(withProjectID: "ProjectName1")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setupUI() {
        
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


extension PFProjectsListViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell    = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                         for: indexPath) as! PFProjectsListCollectionViewCell
        
        let labelText = "P\(indexPath.item)"
        cell.addBorderView(width: CGFloat(1.0),
                           color: kPFPurpleColor.cgColor)
        cell.setupCell(withLabel: labelText)
        
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
}


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

extension PFProjectsListViewController:UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}
