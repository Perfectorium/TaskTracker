//
//  PRProjectsListViewController.swift
//  TaskTracker
//
//  Created by Alex Tsonev on 23.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//


import UIKit

private let reuseIdentifier = "PFProjectsListCollectionViewCell"

class PFProjectsListViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    static func storyboardInstance() -> PFProjectsListViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? PFProjectsListViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    
    
    
    
    
    func signOut()
    {
        
        PFAuthAdapter.signOut { (success) in
            if success
            {
                let appdelegate = UIApplication.shared.delegate as! AppDelegate
                let navigationVC = AppDelegate.createNavigationController()
                appdelegate.window!.rootViewController = navigationVC
                
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
