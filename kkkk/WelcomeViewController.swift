//
//  WelcomeViewController.swift
//  kkkk
//
//  Created by maher1980 on 5/4/16.
//  Copyright © 2016 maher1980. All rights reserved.
//

import UIKit

class WelcomeViewController: UIViewController {

    let backendless = Backendless.sharedInstance()
    var currentuser:BackendlessUser?
    
    // tell the view to stay logged in when there isa current user logged in upon launching app again
   override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(true)
       //call backendless stayloggedin function
        backendless.userService.setStayLoggedIn(true)
       // set the current user to backendless current user
      self.currentuser = backendless.userService.currentUser
        
        //now check if there is a current user
        if currentuser != nil {
            dispatch_async(dispatch_get_main_queue()) {
            //there s a user logged in
            //segue to recent view controller
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ChatVC")as! UITabBarController
            //set it to the first controller of tabbar controller
            VC.selectedIndex = 0
            self.presentViewController(VC, animated: true, completion: nil)
            }
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

   
}
