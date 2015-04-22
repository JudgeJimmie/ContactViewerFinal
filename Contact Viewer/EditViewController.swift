//
//  EditViewController.swift
//  Contact Viewer
//
//  Created by user28317 on 4/16/15.
//  Copyright (c) 2015 James. All rights reserved.
//
import UIKit

class EditViewController: UIViewController {

    
    var editItem: Contact?
    
    @IBOutlet weak var editNameText: UITextField!
    @IBOutlet weak var editTitleText: UITextField!
    @IBOutlet weak var editEmailText: UITextField!
    @IBOutlet weak var editTwitterText: UITextField!
    
    func configureEditView() {
        
        if self.editItem==nil{
            self.title="New Contact"
        }
        else{
            self.title="Edit Contact"
            
            if let editContact: Contact = self.editItem {
                self.editNameText.text = editContact.name
                self.editTitleText.text = editContact.title
                self.editEmailText.text = editContact.email
                self.editTwitterText.text = editContact.twitterId
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {

    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let saveButton = UIBarButtonItem(barButtonSystemItem: .Save, target: self, action: "saveContact:")
        self.navigationItem.rightBarButtonItem = saveButton
        
        self.configureEditView()
    }
    
    func saveContact(sender: AnyObject) {
        
        //      objects.insert(Contact(), atIndex: 0)
        //    let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        //  self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        //self.performSegueWithIdentifier("unwindEditToDetail", sender: nil)
        
        let contactId = "552cfc5e6f3ea2517500fef5"
        
        var err: NSError?
        
        // We need to Put this contact
        let url = NSURL(string:"http://contacts.tinyapollo.com/contacts/\(contactId)?key=fingaGunz")!
        
        // create the request
        var request = NSMutableURLRequest(URL: url)
        request.HTTPMethod = "PUT"
        request.HTTPBody = NSJSONSerialization.dataWithJSONObject(editItem!, options: nil, error: &err)
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        let session = NSURLSession.sharedSession()
        
        let task = session.dataTaskWithRequest(request, completionHandler:{data, response, error -> Void in
            
            // deserialize the response
            
            
            let responseDict = NSJSONSerialization.JSONObjectWithData(data, options:.MutableLeaves, error:&err) as NSDictionary
            
            // pass the string back to the main thread
            NSOperationQueue.mainQueue().addOperationWithBlock {
                // do some main thread stuff stuff
                self.onGotContact(responseDict)
            }
            	
        })
        task.resume()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        /*if segue.identifier == "editContactFromDetail"{
            let controller = segue.destinationViewController as EditViewController
            controller.editItem = self.detailItem
        }*/
    }
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    func onGotContact(responseDict: NSDictionary) {
        self.detailDescriptionLabel!.text = responseDict["ip"] as? String
    }
 }
