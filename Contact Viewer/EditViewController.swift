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
            
                /*
                name: "Malcolm Reynolds", phone: "612-555-1234", title: "Captain", email: "mal@serenity.com", twitterId: "malreynolds")
                */
                
                
                self.editNameText.text = editContact.name
                self.editTitleText.text = editContact.title
                self.editEmailText.text =
                    editContact.email
                self.editTwitterText.text = editContact.twitterId
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        
        //if segue.identifier == "showDetail" || segue.identifier == "newContactFromDetail"{
        
        //  this doesn't work anyway
        //self.title = "New Contact"
        
        
        /*}
        else{
            self.title = "Edit Contact"
        }*/
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.configureEditView()
        
    }
}
