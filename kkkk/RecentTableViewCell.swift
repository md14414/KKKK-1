//
//  RecentTableViewCell.swift
//  kkkk
//
//  Created by maher1980 on 5/5/16.
//  Copyright © 2016 maher1980. All rights reserved.
//

import UIKit

class RecentTableViewCell: UITableViewCell {

    
    @IBOutlet weak var AvatarImage: UIImageView!
    @IBOutlet weak var Namelabel: UILabel!
    
    @IBOutlet weak var Lastmessagelabel: UILabel!
    
    @IBOutlet weak var Datelabel: UILabel!
    
    @IBOutlet weak var Messagecounterlabel: UILabel!
    
    let backendless = Backendless.sharedInstance()

    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func bindData(Recent: NSDictionary){
        //make the avatar image rounded
        self.AvatarImage.layer.cornerRadius = self.AvatarImage.frame.size.width/2
        self.AvatarImage.layer.masksToBounds = true
        //set the avatar image to the default image if user didn't upload an image
        self.AvatarImage.image = UIImage(named: "avatar placeholder")
        
        let WithUserId = (Recent["WithUserUserId"] as? String)!
        //get the user from backendless and download the avatar
        let whereClause = "objectId = '\(WithUserId)'"
        let dataQuery = BackendlessDataQuery()
        dataQuery.whereClause = whereClause
        
        let dataStore = backendless.persistenceService.of(BackendlessUser.ofClass())
        // retrieve the user
        
        dataStore.find(dataQuery, response: { (users: BackendlessCollection!) -> Void in
            let withUser = users.data.first as! BackendlessUser
            //TO DO:  get our withuser avatar
            
        }) { (fault:Fault!) -> Void in
                print("an error happened, couldn't get user avatar\(fault)")
        }
        
        
        
    //set table cell properties
        
   self.Namelabel.text = Recent["withUserUsername"] as? String
   self.Lastmessagelabel.text = Recent["Lastmessage"] as? String
   self.Messagecounterlabel.text = " "
        
        if (Recent["counter"] as? Int)! != 0 {
            self.Messagecounterlabel.text = "\(Recent["counter"]) New"
        }
   // THE DATE OF THE MESSAGE
        let date = dateFormatter().dateFromString((Recent["date"] as? String)!)
        
        let seconds = NSDate().timeIntervalSinceDate(date!)
        self.Datelabel.text = Elapsedtime(seconds)
        
        
        }// end of action function
    
    
    
    // set chat elapsed time function
    func Elapsedtime(seconds: NSTimeInterval)-> String {
        
        let elapsedtime: String?
        
        if (seconds < 60) {
           elapsedtime = "Just now"
        } else if (seconds < 60 * 60) {
        
          let minutes = Int(seconds/60)
           var minText = "min"
            if minutes > 1 {
              minText = "mins"
            }
            elapsedtime = "\(minutes) \(minText)"
        }// end of fitset else if
        else if (seconds < 24 * 60 * 60){
            
            let hours = Int(seconds/(60 * 60))
            var hourText = "hour"
            if hours > 1 {
                hourText = "hours"
            }
            elapsedtime = "\(hours) \(hourText)"
            
        }// end of second else if
        
        else {
            let days = Int(seconds / (24 * 60 * 60 ) )
            var dayText = "day"
            if days > 1 {
                dayText = "days"
            }
            elapsedtime = "\(days) \(dayText)"
        }
        return elapsedtime!
    }// end of elapsed time function
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

}
