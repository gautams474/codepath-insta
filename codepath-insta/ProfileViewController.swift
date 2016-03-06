//
//  ProfileViewController.swift
//  codepath-insta
//
//  Created by Gautam Sadarangani on 3/4/16.
//  Copyright © 2016 Gautam Sadarangani. All rights reserved.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var profileImage: UIImageView!
    var queryData : [PFObject] = []
    var profilepicture: UIImage?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData((PFUser.currentUser()?.username)!)
        
        
        // Do any additional setup after loading the view.
    }
    
    func getData(Username: String) {   //completion: ((Image: UIImage?) -> ())
        //var profilepicture: UIImage?
        let query = PFQuery(className: "ProfilePictures")
        query.whereKey("username",equalTo: Username)
        query.findObjectsInBackgroundWithBlock { (object:[PFObject]?, error:NSError?) -> Void in
            if  object != nil && object?.count != 0{
                self.queryData = object!
                let PPData = self.queryData[0]
                let media = PPData.objectForKey("media") as! PFFile
                media.getDataInBackgroundWithBlock({ (data:NSData?, error:NSError?) -> Void in
                    if data != nil {
                         self.profileImage.image = UIImage(data: data!)
                        self.profilepicture = UIImage(data: data!)

                    }
                })
            }
        }
        //completion(Image: profilepicture)
        //return profilepicture
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func OnLogout(sender: AnyObject) {
        PFUser.logOut()
        NSNotificationCenter.defaultCenter().postNotificationName("UserLoggedOut", object: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
