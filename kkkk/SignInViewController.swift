//
//  SignInViewController.swift
//  kkkk
//
//  Created by maher1980 on 5/4/16.
//  Copyright © 2016 maher1980. All rights reserved.
//

import UIKit

class SignInViewController: UIViewController {

   
    
    
    @IBOutlet weak var emailTxt: UITextField!
    
    @IBOutlet weak var passwordTxt: UITextField!
    
    let backendless = Backendless.sharedInstance()
    
    var email: String?
    var password: String?
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func SignInbarbuttonpressed(sender: UIBarButtonItem) {
        email = self.emailTxt.text
        password = self.passwordTxt.text
        guard  let email = self.emailTxt.text where !email.isEmpty,let password = self.passwordTxt.text where !password.isEmpty else {
          //send a warning that all fields required
            ProgressHUD.showError("all fields are required")
        return
        }
        
        // call login function
        self.LogIn(email, Loginpassword: password)
        
        
        
        
        
        
        
      
    
    
    }// end of action method
    
    
    func LogIn(Loginemail: String, Loginpassword: String){
        backendless.userService.login(Loginemail, password: Loginpassword, response: { (user:BackendlessUser!) -> Void in
            //log in is successful
            print("Logged in")
            // set email and password field empty again
            self.emailTxt.text = nil
            self.passwordTxt.text = nil
            //segue to recent view controller
            let VC = UIStoryboard(name: "Main", bundle: nil).instantiateViewControllerWithIdentifier("ChatVC")as! UITabBarController
            //set it to the first controller of tabbar controller
            VC.selectedIndex = 0
            self.presentViewController(VC, animated: true, completion: nil)

            }) { (fault: Fault!) -> Void in
                // error happened during log in
                print("an error happened during loging in process\(fault)")
        }

    }
    
    
    
    
    
    
   
}
