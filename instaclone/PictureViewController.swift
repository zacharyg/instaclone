//
//  PictureViewController.swift
//  instaclone
//
//  Created by Zachary West Guo on 10/5/16.
//  Copyright © 2016 zechariah. All rights reserved.
//

import UIKit


class PictureViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imagePicked: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerController(picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        // Get the image captured by the UIImagePickerController
        //let originalImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as! UIImage
        
        // Do something with the images (based on your use case)
        imagePicked.image = editedImage;
        
        // Dismiss UIImagePickerController to go back to your original view controller
        dismissViewControllerAnimated(true, completion: nil)
    }

    
    @IBAction func cameraTakeOpen(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    @IBAction func cameraRollOpen(sender: AnyObject) {
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }

    @IBAction func uploadImage(sender: AnyObject) {
//        var captionPost = "";
//        if let caption = captionField.text{
//            
//        }
        if let image = imagePicked.image{
            Post.postUserImage(resize(image, newSize: CGSizeMake(250, 250)), withCaption: captionField.text, withCompletion:{(success: Bool, error: NSError?) -> Void in
                print("posted user image")
            }) //try putting nil?
        }
        
    }
    
    func resize(image: UIImage, newSize: CGSize) -> UIImage {
        let resizeImageView = UIImageView(frame: CGRectMake(0, 0, newSize.width, newSize.height))
        resizeImageView.contentMode = UIViewContentMode.ScaleAspectFill
        resizeImageView.image = image
        
        UIGraphicsBeginImageContext(resizeImageView.frame.size)
        resizeImageView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return newImage
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
