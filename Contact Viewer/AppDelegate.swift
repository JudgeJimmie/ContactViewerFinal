			//
//  AppDelegate.swift
//  Contact Viewer
//
//  Created by user28218 on 4/11/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UISplitViewControllerDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Override point for customization after application launch.
        let splitViewController = self.window!.rootViewController as UISplitViewController
        let navigationController = splitViewController.viewControllers[splitViewController.viewControllers.count-1] as UINavigationController
        navigationController.topViewController.navigationItem.leftBarButtonItem = splitViewController.displayModeButtonItem()
        splitViewController.delegate = self
        
        
        //GET request
        let contactId = "552cfc5e6f3ea2517500fef5"
        let requestURL = NSURL(string:"http://contacts.tinyapollo.com/contacts/\(contactId)?key=fingagunz")!
        
        var request = NSMutableURLRequest(URL: requestURL)
        request.HTTPMethod = "GET"
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler:{data, response, error -> Void in
            
        })
        task.resume()

        return true
    }

    let detailDescriptionLabel: UILabel?
    
    func onGotContact(responseDict: NSDictionary) {
        self.detailDescriptionLabel!.text = responseDict["message"] as? String
    }
    
    func getContact(contactId: String) {
        
        let url = NSURL(string:"http://contacts.tinyapollo.com/contacts/\(contactId)?key=fingagunz")!
        
        // create the request
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "GET"
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler:{data, response, error -> Void in
            
            // deserialize the response
            var err: NSError?
            let responseDict = NSJSONSerialization.JSONObjectWithData(data, options:.MutableLeaves, error:&err) as NSDictionary
            
            // pass the string back to the main thread
            NSOperationQueue.mainQueue().addOperationWithBlock {
                // do some main thread stuff stuff
                self.onGotContact(responseDict)
            }
            
        })
        task.resume()
    }
    
    @IBAction func onButton(sender: AnyObject) {
        self.getContact("552cfc5e6f3ea251")
    }
    	

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    // MARK: - Split view

    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController!, ontoPrimaryViewController primaryViewController:UIViewController!) -> Bool {
        if let secondaryAsNavController = secondaryViewController as? UINavigationController {
            if let topAsDetailController = secondaryAsNavController.topViewController as? DetailViewController {
                if topAsDetailController.detailItem == nil {
                    // Return true to indicate that we have handled the collapse by doing nothing; the secondary controller will be discarded.
                    return true
                }
            }
        }
        return false
    }

}

