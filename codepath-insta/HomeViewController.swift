//
//  HomeViewController.swift
//  codepath-insta
//
//  Created by Gautam Sadarangani on 3/5/16.
//  Copyright © 2016 Gautam Sadarangani. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    let refreshControl = UIRefreshControl()

    var queryData : [PFObject] = []
    var ppData: [PFObject] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        
        //refreshControl.addTarget(self, action: "refreshControlAction:", forControlEvents: UIControlEvents.ValueChanged)
       // tableView.insertSubview(refreshControl, atIndex: 0)
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        getData()
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getData() {
        
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.limit = 20
        query.findObjectsInBackgroundWithBlock { (object:[PFObject]?, error:NSError?) -> Void in
            print(object)
            print(object?.count)
            if  object != nil && object?.count != 0{
                self.queryData = object!
                print(self.queryData)
                self.tableView.reloadData()
            }
            
        }
        
    }
    
    func refreshControlAction(refreshControl: UIRefreshControl) {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        getData()
        self.refreshControl.endRefreshing()
        MBProgressHUD.hideHUDForView(self.view, animated: true)
    }
    
    
        func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("HomeCell") as? HomeCell
        if queryData.count > 0{
        let postData = self.queryData[indexPath.row]
        let media = postData.objectForKey("media") as! PFFile
        //let updatedAt = postData.updatedAt
        //cell!.postImage.image = UIImage(named: "icon")
            let caption = postData.objectForKey("caption") as! String
            cell!.label2.text = caption
            let author = postData.objectForKey("username") as! String
            cell!.label.text = author
        media.getDataInBackgroundWithBlock({ (data:NSData?, error:NSError?) -> Void in
            if data != nil {
                cell!.postImage.image = UIImage(data: data!)
            }
        })
        
        let ppquery = PFQuery(className: "ProfilePictures")
        ppquery.whereKey("username", equalTo: author)
        ppquery.findObjectsInBackgroundWithBlock { (object:[PFObject]?, error:NSError?) -> Void in
        if  object != nil && object?.count != 0{
                self.ppData = object!
                self.tableView.reloadData()
            }
        }

        if self.ppData.count > 0 {
       
            let profiles = self.ppData[0]
            print(profiles)
            let media = profiles.objectForKey("media") as! PFFile
            media.getDataInBackgroundWithBlock({ (data:NSData?, error:NSError?) -> Void in
                if data != nil {
                    cell!.profileView.clipsToBounds = true
                    cell!.profileView.layer.cornerRadius = 15;
                    cell!.profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
                    cell!.profileView.layer.borderWidth = 1;
                    cell!.profileView.image = UIImage(data: data!)
                }
            })
        }
        }

        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return queryData.count
    }
  /*
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 45
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 50))
    headerView.backgroundColor = UIColor(white: 1, alpha: 0.9)
    
    /*
    let profileView = UIImageView(frame: CGRect(x: 10, y: 10, width: 30, height: 30))
    profileView.clipsToBounds = true
    profileView.layer.cornerRadius = 15;
    profileView.layer.borderColor = UIColor(white: 0.7, alpha: 0.8).CGColor
    profileView.layer.borderWidth = 1;
    */
    //         Use the section number to get the right URL
    //         profileView.setImageWithURL(...)
    
    // Add a UILabel for the username here
    let label = UILabel(frame: CGRect(x: 0, y: 5, width: 320, height: 50))
    //let label2 = UILabel(frame: CGRect(x: 0, y: 55, width: 320, height: 50))
    label2.textAlignment = NSTextAlignment.Center
    
    //        label.center = CGPointMake(160, 284)
    label.textAlignment = NSTextAlignment.Center
   
    print(section)
    if self.queryData.count > 0{
        let postData = self.queryData[section]
        
        //print(postData)
    
        let caption = postData.objectForKey("caption") as! String
        label2.text = caption
        let author = postData.objectForKey("username") as! String
        label.text = author
        
    }
     profileView.image = UIImage(named: "home")   
    if self.ppData.count > 0 {
        let profiles = self.ppData[section]
        print(profiles)
        let media = profiles.objectForKey("media") as! PFFile
        media.getDataInBackgroundWithBlock({ (data:NSData?, error:NSError?) -> Void in
            if data != nil {
                    
                    profileView.image = UIImage(data: data!)
            }
        })
    }
    
 /*   profileView.image = UIImage(named: "icon")
    
    media.getDataInBackgroundWithBlock({ (data:NSData?, error:NSError?) -> Void in
    if data != nil {
    
        
    profileView.image = UIImage(data: data!)
    }
    })
*/
    headerView.addSubview(label)
 //   headerView.addSubview(profileView)
    
    return headerView
    }
    */
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
