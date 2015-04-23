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
        
        var contactId = self.editItem?.id
            
        var jsonString = [ "name" : self.editNameText!.text,
                "title" : self.editTitleText!.text,
                "phone" : self.editPhoneText!.text,
                "email" : self.editEmailText!.text,
                "twitterId" : self.editTwitterText!.text]
            
        var err: NSError?
        
        
        var urlStr = "http://contacts.tinyapollo.com/contacts?key=fingagunz"
        
        if self.editItem != nil {
            urlStr = "http://contacts.tinyapollo.com/contacts/" + (contactId! as String) + "?key=fingagunz"
        }
        
        let url = NSURL(string: urlStr)!
        
        // create the request
        var request = NSMutableURLRequest(URL: url)
        
        if self.editItem == nil {
            request.HTTPMethod = "POST"
            //jsonString["_id"] = contactId! as String
        }
        else{
            request.HTTPMethod = "PUT"
            jsonString["_id"] = contactId! as String
        }
        
            
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
          
            var strData = NSString(data: data, encoding: NSUTF8StringEncoding)
            
            // deserialize the response
            let responseDict = NSJSONSerialization.JSONObjectWithData(data, options:.MutableLeaves, error:&err) as NSDictionary
                        // pass the string back to the main thread
            NSOperationQueue.mainQueue().addOperationWithBlock {
                // do some main thread stuff stuff
                self.onGotContact(responseDict)
                // TODO Update the Views!!
            
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
        
        // If there is no contact, create one, otherwise just update the fields.
        if self.editItem == nil {
            
            let editItem = Contact(name: editNameText.text, phone: editPhoneText.text, title: editTitleText.text, email: editEmailText.text, twitterId: editTwitterText.text, id: responseDict["_id"] as String)
            
            
            // TODO Find the contact ID, Add to the contacts array
        } else {
            // Edit the existing contacts info
            editItem?.name = editNameText.text
            editItem?.phone = editPhoneText.text
            editItem?.title = editTitleText.text
            editItem?.email = editEmailText.text
            editItem?.twitterId = editTwitterText.text
        }
    }
 }
