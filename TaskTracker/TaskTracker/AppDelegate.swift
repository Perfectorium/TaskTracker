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
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = AppDelegate.createRootController()
        self.window?.makeKeyAndVisible()
        
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
    
    
    class func createRootController(registration: Bool = false) -> UIViewController {
        
        let signedIn = UserDefaults.standard.value(forKey: kIsSignedIn) as? Bool ?? false
        let rootController: UIViewController?
        if signedIn
        {
            
            let homeViewController = PFProjectsListViewController.storyboardInstance()!
            let leftController = PFLeftSlideMenuController.storyboardInstance()
            let slideViewController = SlideMenuController(mainViewController: homeViewController,
                                                          leftMenuViewController: leftController!)
            rootController = slideViewController
        }
        else
        {
            guard let root = PFLoginViewController.storyboardInstance()
                else
            {
                return UINavigationController()
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
        }
        return rootController!
        
    }
    

    // MARK: - Core Data stack

    
    lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "TaskTracker")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    
    // MARK: - Core Data Saving support

    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
}

