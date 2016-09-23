//
//  LoginViewController.swift
//  instaclone
//
//  Created by Zachary West Guo on 9/23/16.
//  Copyright © 2016 zechariah. All rights reserved.
//

import UIKit
import Parse

class LoginViewController: UIViewController {

    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSignIn(sender: AnyObject) {
    }
    
    @IBAction func onSignUp(sender: AnyObject) {
        
        if(validSignUp()){
            let newUser = PFUser();
            newUser.username = usernameField.text// ?? "admin"
            newUser.password = passwordField.text// ?? "admin"
            newUser.signUpInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
                if let error = error {
                    print(error.localizedDescription)
                } else {
                    print("User Registered successfully")
                    // manually segue to logged in view
                }
            }
            
        }
        else{
            let alert = UIAlertController(title: "Error", message: "Invalid entry for username or password.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
        }
        
        
        
    }
    
    func validSignUp()->Bool{
        if let text = usernameField.text where text.isEmpty
        {
            return false;
        }
        if let text = passwordField.text where text.isEmpty
        {
            return false;
        }
        
        return true;
    }
    
    
    @IBAction func tappedOutside(sender: AnyObject) {
        self.view.endEditing(true);
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
