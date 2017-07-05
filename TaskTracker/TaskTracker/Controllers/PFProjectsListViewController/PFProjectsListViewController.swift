//
//  PRProjectsListViewController.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 23.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//


import UIKit

private let reuseIdentifier = "PFProjectsListCollectionViewCell"

class PFProjectsListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout, UITextFieldDelegate {
    
    
    // MARK: - Vars & constants
    
    
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
        setupHeaderView()
    }
    
    func setupHeaderView() {
        
        self.collectionView?.register(PFProjectsListHeaderView.self,
                                      forSupplementaryViewOfKind: UICollectionElementKindSectionHeader,
                                      withReuseIdentifier: PFProjectsListHeaderView.reuseIdentifier!)
    }
    
    
    // MARK: - UICollectionViewDataSource
    
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.size.width/5.2
        return CGSize(width: width,
                      height: width)
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell    = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier,
                                                         for: indexPath) as! PFProjectsListCollectionViewCell
        
        let labelText = "P\(indexPath.item)"
        cell.setupCell(withLabel: labelText, color: UIColor.randomColor())
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView,
                                 viewForSupplementaryElementOfKind kind: String,
                                 at indexPath: IndexPath) -> UICollectionReusableView {
        
        switch kind {
        case UICollectionElementKindSectionHeader:
            let reusableView = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader,
                                                                               withReuseIdentifier: PFProjectsListHeaderView.reuseIdentifier!,
                                                                               for: indexPath) as! PFProjectsListHeaderView
            reusableView.delegate = self
            //do other header related calls or settups
            return reusableView
            
            
        default:  fatalError("Unexpected element kind")
        }
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
    
}
