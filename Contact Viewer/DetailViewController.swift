//
//  DetailViewController.swift
//  Contact Viewer
//
//  Created by user28218 on 4/11/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import UIKit

var detailItem: Contact?

class DetailViewController: UIViewController {

    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailTitleLabel: UILabel!
    @IBOutlet weak var detailEmailLabel: UILabel!
    @IBOutlet weak var detailTwitterLabel: UILabel!
    @IBOutlet weak var detailPhoneLabel: UILabel!

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: Contact = detailItem {
            self.detailNameLabel.text = detail.name
            self.detailTitleLabel.text = "Title:  " + detail.title
            self.detailEmailLabel.text = "Email:  " + detail.email
            self.detailTwitterLabel.text = "Twitter ID:  " + detail.twitterId
            self.detailPhoneLabel.text = "Phone:  " + detail.phone
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        self.configureView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "editContact:")
        self.navigationItem.rightBarButtonItem = editButton
        
        
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func editContact(sender: AnyObject) {
        //      objects.insert(Contact(), atIndex: 0)
        //    let indexPath = NSIndexPath(forRow: 0, inSection: 0)
        //  self.tableView.insertRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
              
        self.performSegueWithIdentifier("editContactFromDetail", sender: nil)
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
            if segue.identifier == "editContactFromDetail"{
                let controller = segue.destinationViewController as EditViewController
                controller.editItem = detailItem
        }
    }
    
}

