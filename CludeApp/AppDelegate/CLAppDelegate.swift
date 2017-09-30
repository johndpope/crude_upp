//
//  AppDelegate.swift
//  CludeApp
//
//  Created by Reus on 02/09/17.
//  Copyright © 2017 Reus. All rights reserved.
//

import UIKit
import CoreData
import GoogleMaps
import IQKeyboardManagerSwift
import MagicalRecord
import FLEX

let _appDelegate = UIApplication.shared.delegate as! CLAppDelegate

@UIApplicationMain
class CLAppDelegate: UIResponder, UIApplicationDelegate {

    
    // Final Commit 29thSep
    
    var window: UIWindow?
    let locationManager =  CLLocationManager()

    var questionAlreadyinWindow:Bool = false
    var timeStopperShow:Bool = false
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        IQKeyboardManager.sharedManager().enable = true
        self.locationPermission()
        GMSServices.provideAPIKey(CLConstant.Keys.map)

        UIApplication.shared.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)

        // magical core data record
        
        //MagicalRecord.setupCoreDataStack(withStoreNamed: "CludeApp")
        
        MagicalRecord.setupCoreDataStack(withAutoMigratingSqliteStoreNamed: "CludeApp.sqlite")

        
       // FLEXManager.shared().showExplorer()
        
        saveMagicalContext()

        DispatchQueue.main.async {
            
           // let event_continue = Event_db_cludeUpp.mr_findAll() as! [Event_db_cludeUpp]
            
            if UserDefaults.standard.value(forKey: CLConstant.runningEventTeamID) != nil{
            
                let Predicate = NSPredicate(format: "teamID = %@", UserDefaults.standard.value(forKey: CLConstant.runningEventTeamID) as! String)
                
                if Event_db_cludeUpp.mr_countOfEntities(with: Predicate) > 0 {
                    // save local event id
                    let event_local = Event_db_cludeUpp.mr_findAll(with: Predicate)[0] as! Event_db_cludeUpp
                    
                    let aViewController = CLConstant.storyBoard.dashBoard.instantiateViewController(withIdentifier: String(describing: CLDashBoardVC.self)) as! CLDashBoardVC
                    aViewController.event_local = event_local
                   self.setInitalViewController(viewControler: aViewController)
                }
                
            }
            
           
            
        }
        
        return true
    }
    
    
    func locationPermission() {
        
        locationManager.requestWhenInUseAuthorization()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        if #available(iOS 8.0, *) {
            locationManager.requestWhenInUseAuthorization()
            
        } else {
            // Fallback on earlier versions
        }
        locationManager.startUpdatingLocation()
    }

    
    func setInitalViewController(viewControler:UIViewController) {
        
        let navigationController = UINavigationController.init(rootViewController: viewControler)
        navigationController.navigationBar.isHidden = true
        self.window?.rootViewController = navigationController
        self.window?.makeKeyAndVisible()
        
    }


    func saveMagicalContext(){
        
        NSManagedObjectContext.mr_default().mr_saveToPersistentStore(completion: nil)
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        NSManagedObjectContext.mr_default().mr_saveToPersistentStore(completion: nil)
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        NSManagedObjectContext.mr_default().mr_saveToPersistentStore(completion: nil)
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
        self.saveMagicalContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "CludeApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
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
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

