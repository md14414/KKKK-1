//
//  Recent.swift
//  kkkk
//
//  Created by maher1980 on 5/8/16.
//  Copyright © 2016 maher1980. All rights reserved.
//

import Foundation
import Firebase

//Back endless and firebase references

let firebaseRef = Firebase(url: "https://stemi.firebaseio.com/")
let backendless = Backendless.sharedInstance()
let currentUser = backendless.userService.currentUser
//HELPER FUNCTIONS

private let dateFormat = "yyyymmddhhmmss"

func dateFormatter()-> NSDateFormatter {
    let dateFormatter = NSDateFormatter()
    dateFormatter.dateFormat = dateFormat
    
    return dateFormatter
}