//
//  SignUpViewController.swift
//  kkkk
//
//  Created by maher1980 on 5/4/16.
//  Copyright © 2016 maher1980. All rights reserved.
//

import UIKit
import Firebase
class SignUpViewController: UIViewController {

   // Story board outlet
    
    @IBOutlet weak var UsernameTxt: UITextField!
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var PasswordTxt: UITextField!
    
    //back endless property
    var backendless = Backendless.sharedInstance()
    
    // create backendless new user and its properties
    var newUser: BackendlessUser?
    var email: String?
    var username: String?
    var password: String?
    var avatarImage: UIImage?
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    newUser = BackendlessUser()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func SignupPressed(sender: UIButton) {
       
        self.email = self.emailTxt.text
        self.username = self.UsernameTxt.text
        self.password = self.PasswordTxt.text
        
        
        guard let username = self.UsernameTxt.text where !username.isEmpty, let email = self.emailTxt.text where !email.isEmpty,let password = self.PasswordTxt.text where !password.isEmpty else {
            //there some field missing
             ProgressHUD.showError("all fields are required")
            return
        }
        ProgressHUD.show("registration in progress...")
         register(self.email!, password: self.password!, username: self.username!, avatarImage: self.avatarImage)
        
        
    
    
    }// end of action method
    
    // Bckendless user registration
    
    func register(email:String, password:String, username:String, avatarImage: UIImage?){
        // create a new backendless property for the avatarimage ( not created by default)
        if avatarImage == nil {
            newUser?.setProperty("Avatar", object: " ")
        }
        // set backendless newUser properties( these three created by default by backendless)
        newUser!.email = email
        newUser!.password = password
        newUser!.name = username
        
        backendless.userService.registering(newUser!, response: { (registeredUser: BackendlessUser!) -> Void in
            // registration is successful, log in the user by calling login function
            self.LogIn(email, Loginusername: username, Loginpassword: password)
            ProgressHUD.dismiss()
            // now clear all textfields again
            self.UsernameTxt.text = " "
            self.emailTxt.text = " "
            self.PasswordTxt.text = " "
            
            }) { (fault: Fault!) -> Void in
            // error happened
                //print("error occured during sign up process\(fault)")
        }
    }// end of register
    
    
    
    // create a log in function
    func LogIn(Loginemail: String, Loginusername: String, Loginpassword: String){
        
        backendless.userService.login(Loginemail, password: Loginpassword, response: { (user:BackendlessUser!) -> Void in
            //log in is successful
            //segue to recent view controller
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ChatVC")as! UITabBarController
            //set it to the first controller of tabbar controller
            VC.selectedIndex = 0
            self.presentViewController(VC, animated: true, completion: nil)
            
            }) { (fault: Fault!) -> Void in
                // error happened during log in
                print("an error happened during log in process\(fault)")
        }
        
    }
    
    
    
    
    

   
}
