//
//  Contact.swift
//  Contact Viewer
//
//  Created by user28218 on 4/11/15.
//  Copyright (c) 2015 James. All rights reserved.
//

import Foundation
class Contact: NSObject {
    
    var name:String
    var phone:String
    var title:String
    var email:String
    var twitterId:String
    
    init(name:String, phone:String, title:String, email:String, twitterId:String) {
        self.name = name
        self.phone = phone
        self.title = title
        self.email = email
        self.twitterId = twitterId
    }
}