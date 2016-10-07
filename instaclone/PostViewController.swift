//
//  PostViewController.swift
//  instaclone
//
//  Created by Zachary West Guo on 10/5/16.
//  Copyright © 2016 zechariah. All rights reserved.
//

import UIKit
import Parse

class PostViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var timer: NSTimer!
    var q: [PFObject] = [PFObject]();

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self

        // Do any additional setup after loading the view.
        //timer = NSTimer.scheduledTimerWithTimeInterval(1.0, target: self, selector: #selector(PostViewController.onTimer), userInfo: nil, repeats: true)
        
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(PostViewController.loadData), forControlEvents: UIControlEvents.ValueChanged)
        tableView.insertSubview(refreshControl, atIndex: 0)
        
    }
    
    // Makes a network request to get updated data
    // Updates the tableView with the new data
    // Hides the RefreshControl


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func loadData(){
        let query = PFQuery(className: "Post")
        query.orderByDescending("createdAt")
        query.includeKey("author")
        query.limit = 20
        query.findObjectsInBackgroundWithBlock { (posts: [PFObject]?, error: NSError?) -> Void in
            
            if error == nil {
                // The find succeeded.
                print("Successfully retrieved \(posts!.count) messages.")
                // Do something with the found objects
                if let posts = posts {
                    self.q = posts;
                    self.tableView.reloadData()
                    
                }
            } else {
                // Log details of the failure
                print("Error: \(error!) \(error!.userInfo)")
            }
        }

        
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return q.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("PostCell", forIndexPath: indexPath) as! PostCell
        let post = q[indexPath.row]
        let user = post["author"] as! PFUser
        cell.userNameLabel.text = user.username
        let caption = post["caption"] as! String
        cell.captionLabel.text = caption
        let userImageFile = post["media"]
        userImageFile.getDataInBackgroundWithBlock {
            (imageData: NSData?, error: NSError?) -> Void in
            if error == nil {
                if let imageData = imageData {
                    let image = UIImage(data:imageData)
                    cell.imageView?.image = image

                }
            }
        }
                let likes = post["likesCount"] as! Int
        cell.likesLabel.text = "\(likes)"
        
        return cell
    }
    
    func onTimer(){
        //print("refresh")
        loadData()
        self.tableView.reloadData()
        
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
