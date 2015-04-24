//
//  MasterViewController.swift
//  Contact Viewer
//
//  Created by user28218 on 4/11/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var contacts = [Contact]()
    var myContacts = []
    var isLoaded = false

    override func awakeFromNib() {
        
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
        
        //TODO: Get the contacts already saved on the tinyapollo server
    //    getContacts()
    }
    
    func getContacts() {
        
        //TODO: Get the contacts already saved on the tinyapollo server
        let url = NSURL(string:"http://contacts.tinyapollo.com/contacts/?key=fingagunz")!
        
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
                self.parseContacts(responseDict)
                self.tableView.reloadData()
            }
        })
        task.resume()
    }

    // TODO add the contacts to the contact viewer
    func parseContacts(responseDict: NSDictionary) {
        
        println("Hi")
        if let allContacts: AnyObject = responseDict["contacts"] {
            for (var i = 0; i < allContacts.count; i++) {
                
                println(allContacts[i]["name"] as String)
                println(allContacts[i]["email"] as String)
                println(allContacts[i]["phone"] as String)
                println(allContacts[i]["twitterId"] as String)
                println(allContacts[i]["_id"] as String)
                
                let myContact = Contact(name: allContacts[i]["name"] as String, phone: allContacts[i]["phone"] as String, title: allContacts[i]["title"] as String, email: allContacts[i]["email"] as String, twitterId: allContacts[i]["twitterId"] as String, id: allContacts[i]["_id"] as String)
                
                contacts.append(myContact)
            }
        }
    }
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.navigationItem.leftBarButtonItem = self.editButtonItem()

        let addButton = UIBarButtonItem(barButtonSystemItem: .Add, target: self, action: "insertNewObject:")
        self.navigationItem.rightBarButtonItem = addButton
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func insertNewObject(sender: AnyObject) {
  //      objects.insert(Contact(), atIndex: 0)
    //    let indexPath = NSIndexPath(forRow: 0, inSection: 0)
      //  self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        
        
        self.performSegueWithIdentifier("newContactFromMaster", sender: nil)
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let contact = contacts[indexPath.row]
                let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
                controller.detailItem = contact
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
        else if segue.identifier == "newContact"{
            
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        contacts.removeAll(keepCapacity: true)
        getContacts()
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }


    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let contact = contacts[indexPath.row]
        cell.textLabel!.text = contact.name
        cell.detailTextLabel!.text = "\(contact.phone)      \(contact.email)"
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }

    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            
            let contact = contacts[indexPath.row]
            
            contacts.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            
            //TODO Delete The contact from the saved data
            let contactId = contact.id
            let urlStr = "http://contacts.tinyapollo.com/contacts/" + (contactId as String) + "?key=fingagunz"
            let url = NSURL(string: urlStr)!
            
            // create the request
            var err: NSError?
            var request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "DELETE"
            let session = NSURLSession.sharedSession()
            
            let task = session.dataTaskWithRequest(request, completionHandler:{data, response, error -> Void in
                
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
                
                // deserialize the response
                let responseDict = NSJSONSerialization.JSONObjectWithData(data, options:.MutableLeaves, error:&err) as NSDictionary
            })
            task.resume()
            
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
        }
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        
    }
    
    func post(params : Dictionary<String, String>, url : String) {}

}

