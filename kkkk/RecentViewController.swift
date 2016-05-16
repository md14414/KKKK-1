//
//  RecentViewController.swift
//  kkkk
//
//  Created by maher1980 on 5/5/16.
//  Copyright © 2016 maher1980. All rights reserved.
//

import UIKit

class RecentViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, ChooseuserDelegate {

    @IBOutlet weak var tableview: UITableView!
    
     var chooseuser: ChooseUserViewController = ChooseUserViewController()
    var recents: [NSDictionary] = []
    override func viewDidLoad() {
        super.viewDidLoad()
       
       self.tableview.delegate = self
       self.tableview.dataSource = self
      
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
      // will have only one section
        return 1
    }
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.recents.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        // to reuse the cell using the identifier
        let cell = tableview.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! RecentTableViewCell
        
        //get recent item for the cell at specific indexpath
        let recent = self.recents[indexPath.row]
        
        // retrieve the cell items from backendless
        cell.bindData(recent)
        
        //return the cell
        return cell
        
    }
    
    // go to the chat room once a recnet row tapped
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        // deselct the user once selected
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
       
        //go to the chat room VC
        performSegueWithIdentifier("recenttochstroomsegue", sender: indexPath)
    }
    
    
    // Nvigation b/w view controller, prepare the segue
    
    
    
    
    @IBAction func Composebarbuttonpressed(sender: UIBarButtonItem) {
   //perform the segue
        performSegueWithIdentifier("recenttochooseuserVC", sender: self)
    
    
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue == "recenttochooseuserVC" {
            
            let VC = segue.destinationViewController as! ChooseUserViewController
            // assign this VC to choosecontroller delelgate
            VC.delegate = self
            
        }
        if segue == "recenttochstroomsegue" {
            
            let indexPath = sender as! NSIndexPath
            
            let chatVC = segue.destinationViewController as! ChatRoomViewController
            
            let recent = recents[indexPath.row]
            
            // set chatVC to recent

        
        }// end of prepare for segue

     }
    
    
    func createchatroom(withUser: BackendlessUser){
        let chatVC = ChatRoomViewController()
       // use this method instead of segue, either on works
        navigationController?.pushViewController(chatVC, animated: true)
        //performSegueWithIdentifier("recenttochstroomsegue", sender: chatVC)
        chatVC.hidesBottomBarWhenPushed = true
        // set chatVC to recent
    }

}
