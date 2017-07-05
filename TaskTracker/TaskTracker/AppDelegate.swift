//
//  AppDelegate.swift
//  TaskTracker
//
//  Created by Valeriy Jefimov on 23.06.17.
//  Copyright © 2017 Perfectorium. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import SlideMenuControllerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var rootVC: PFLoginViewController?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        createRootController()
        return true
    }
    
    func application(_ application: UIApplication,
                     continue userActivity: NSUserActivity,
                     restorationHandler: @escaping ([Any]?) -> Void) -> Bool {
        
        //
        //        self.window = UIWindow(frame: UIScreen.main.bounds)
        //        self.window?.rootViewController = AppDelegate.createNavigationController(registration: true)
        
        let url = userActivity.webpageURL!
        PFAuthAdapter.passActivityURL(url)
        
        //self.window?.makeKeyAndVisible()
        guard let parameters = UserDefaults.standard.value(forKey: kParametersKey) as! [String:Any]?
            else {
                return true
        }
        let role = parameters[kRole] as! String? ?? ""
        rootVC?.configureRoleLabel(withRole: role)
        return true
    }
    
    
    // MARK: - Navigation
    
    
    func createRootController(registration: Bool = false)  {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let signedIn = UserDefaults.standard.value(forKey: kIsSignedIn) as? Bool ?? false
        var rootController: UIViewController?
        if signedIn
        {
            let homeViewController = PFProjectsListViewController.storyboardInstance()!
            let root = PFSlideMenuController.newRigthController(with: homeViewController)
            let navRoot = UINavigationController(rootViewController: root)
            self.window?.rootViewController = navRoot
        }
        else
        {
            guard let root = PFLoginViewController.storyboardInstance()
                else
            {
                self.window?.rootViewController = UINavigationController()
                self.window?.makeKeyAndVisible()
                return
            }
            let registration = UserDefaults.standard.value(forKey: kIsRegistered) as? Bool ?? false
            if registration
            {
                root.authType = .registration
            }
            else
            {
                root.authType = .login
            }
            rootController = UINavigationController(rootViewController: root)
            let delegate = UIApplication.shared.delegate as! AppDelegate
            delegate.rootVC = root
            self.window?.rootViewController = rootController!
        }
        self.window?.makeKeyAndVisible()
    }
}

