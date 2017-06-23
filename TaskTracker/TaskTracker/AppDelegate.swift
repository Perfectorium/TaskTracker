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

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
      
        FirebaseApp.configure()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        let signedIn = UserDefaults.standard.value(forKey: kIsSignedIn) as? Bool ?? false
        var initialViewController: UIViewController?
        
        if signedIn
        {
            initialViewController = PFProjectsListViewController.storyboardInstance()
        }
        else
        {
            initialViewController = PFLoginViewController.storyboardInstance()
        }
        
        self.window?.rootViewController = initialViewController
        self.window?.makeKeyAndVisible()
        
        return true
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

