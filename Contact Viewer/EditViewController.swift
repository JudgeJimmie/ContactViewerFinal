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
    
    func configureEditView() {
        
        if self.editItem==nil{
            self.title="New Contact"
        }
        // Update the user interface for the detail item.
        if let editContact: Contact = self.editItem {
            
            
            self.editNameText.text = editContact.name
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
