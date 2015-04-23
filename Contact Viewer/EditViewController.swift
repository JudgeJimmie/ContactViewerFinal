//
//  EditViewController.swift
//  Contact Viewer
//
//  Created by user28317 on 4/16/15.
//  Copyright (c) 2015 James. All rights reserved.
//
import UIKit
import Foundation

class EditViewController: UIViewController {

    
    var editItem: Contact?
    
    @IBOutlet weak var editNameText: UITextField!
    @IBOutlet weak var editTitleText: UITextField!
    @IBOutlet weak var editEmailText: UITextField!
    @IBOutlet weak var editTwitterText: UITextField!
    @IBOutlet weak var editPhoneText: UITextField!
    
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
                self.editPhoneText.text = editContact.phone
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
    
    func post(params : Dictionary<String, String>, url : String) {
        
        
    }
    
    func saveContact(sender: AnyObject) {
        
        //      objects.insert(Contact(), atIndex: 0)
        //    let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        //  self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        
        //self.performSegueWithIdentifier("unwindEditToDetail", sender: nil)
        
        // Create JSON object from Contact to save:
        
        if self.editItem == nil {
            
            var jsonString = [ "Name" : self.editNameText!.text, "Title" : self.editTitleText!.text, "Phone" : self.editPhoneText!.text, "Email" : self.editEmailText!.text, "Twitter" : self.editTwitterText!.text ]
            
            var err: NSError?
            
            // We need to Put this contact
            let url = NSURL(string:"http://contacts.tinyapollo.com/contacts/?key=fingagunz")!

            


            println(url)
            // create the request
            var request = NSMutableURLRequest(URL: url)
            
            // Set up the request
            request.HTTPMethod = "POST"
            
            // Ensure my created string is a valid JSON object before using datawithJSONObject
            if NSJSONSerialization.isValidJSONObject(jsonString) {
                
                // Create and set the JSON object to save
                let jsonObject = NSJSONSerialization.dataWithJSONObject(jsonString, options: nil, error: &err)
                request.HTTPBody = jsonObject
            }
            
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            
            let session = NSURLSession.sharedSession()
            
            let task = session.dataTaskWithRequest(request, completionHandler:{data, response, error -> Void in
                
                println("Response: \(response)")
                var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
                println("Body: \(strData)")
                
                // deserialize the response
                let responseDict = NSJSONSerialization.JSONObjectWithData(data, options:.MutableLeaves, error:&err) as NSDictionary
               /*
                // pass the string back to the main thread
                NSOperationQueue.mainQueue().addOperationWithBlock {
                    // do some main thread stuff stuff
                    self.onGotContact(responseDict)
                }
                */
            })
            task.resume()
            
        } else {
            var contactId = self.editItem?.id
            
            var jsonString = [ "Name" : self.editNameText!.text, "Title" : self.editTitleText!.text, "Phone" : self.editPhoneText!.text, "Email" : self.editEmailText!.text, "Twitter" : self.editTwitterText!.text,"_id" : contactId ]
            
            var err: NSError?
        
            // We need to Put this contact
            let url = NSURL(string:"http://contacts.tinyapollo.com/contacts/" + contactId! + "?key=fingagunz&Name="+self.editNameText!.text+"&Title=" + self.editTitleText!.text+"&Phone=" + self.editPhoneText!.text+"&Email=" + self.editEmailText!.text+"&Twitter=" + self.editTwitterText!.text)!
        
println(url)
            // create the request
            var request = NSMutableURLRequest(URL: url)
        
            // Set up the request
            request.HTTPMethod = "PUT"
        
            // Ensure my created string is a valid JSON object before using datawithJSONObject
            if NSJSONSerialization.isValidJSONObject(jsonString) {
            
                // Create and set the JSON object to save
                let jsonObject = NSJSONSerialization.dataWithJSONObject(jsonString, options: nil, error: &err)
                request.HTTPBody = jsonObject
            }
        
            request.addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
        
            let session = NSURLSession.sharedSession()
        
            let task = session.dataTaskWithRequest(request, completionHandler:{data, response, error -> Void in
          
            println("Response: \(response)")
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            println("Body: \(strData)")
            
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
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        /*if segue.identifier == "editContactFromDetail"{
            let controller = segue.destinationViewController as EditViewController
            controller.editItem = self.detailItem
        }*/
    }
    
    @IBOutlet weak var detailDescriptionLabel: UILabel!
    
    func onGotContact(responseDict: NSDictionary) {
        self.editTwitterText.text = responseDict["Name"] as? String
    }
 }
