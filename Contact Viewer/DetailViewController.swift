//
//  DetailViewController.swift
//  Contact Viewer
//
//  Created by user28218 on 4/11/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet weak var detailDescriptionLabel: UILabel!


    var detailItem: Contact?

    func configureView() {
        // Update the user interface for the detail item.
        if let detail: Contact = self.detailItem {
            if let label = self.detailDescriptionLabel {
                label.text = detail.name
            }
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let editButton = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "editContact:")
        self.navigationItem.rightBarButtonItem = editButton
        
        
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
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
                controller.editItem = self.detailItem
        }
    }
    
}

