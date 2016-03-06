//
//  PhotoViewController.swift
//  codepath-insta
//
//  Created by Gautam Sadarangani on 3/4/16.
//  Copyright © 2016 Gautam Sadarangani. All rights reserved.
//

import UIKit
import Parse
import MBProgressHUD

class PhotoViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    @IBOutlet weak var FrontView: UIView!
    @IBOutlet weak var backView: UIView!
    @IBOutlet weak var frontImage: UIImageView!
    @IBOutlet weak var captionField: UITextField!
    var newImage: UIImage?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        backView.hidden = true
        FrontView.hidden = false
        frontImage.userInteractionEnabled = true;
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated);
        backView.hidden = true
        FrontView.hidden = false
        frontImage.userInteractionEnabled = true;
        
    }
    @IBAction func OnImageTap(sender: AnyObject) {
        FrontView.hidden = true
        backView.hidden = false
    }

    @IBAction func OnCameraRoll(sender: AnyObject) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        
        self.presentViewController(vc, animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
       
        //var newImage: UIImage
        
        if let possibleImage = info["UIImagePickerControllerEditedImage"] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info["UIImagePickerControllerOriginalImage"] as? UIImage {
            newImage = possibleImage
        } else {
            return
        }
        
        /*
        let originalImage = info[UIImagePickerControllerOriginalImage] as? UIImage
        let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage
        
        newImage = editedImage
        */
        // do something interesting here!
        print(newImage!.size)
        frontImage.image = newImage
        dismissViewControllerAnimated(true, completion: nil)
        backView.hidden = true
        FrontView.hidden = false
    }
    
    @IBAction func OnPicture(sender: AnyObject) {
        
        let vc = UIImagePickerController()
        vc.delegate = self
        vc.allowsEditing = true
        vc.sourceType = UIImagePickerControllerSourceType.Camera
        
        self.presentViewController(vc, animated: true, completion: nil)
    }


    @IBAction func OnSubmit(sender: AnyObject) {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        Post.postUserImage(newImage, withCaption: captionField.text) { (success: Bool, error: NSError?) -> Void in
            if success{
                print("Uploaded Image")
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            }
            if(error != nil){
                print(error?.localizedDescription)
            }
        }
    }
    
    @IBAction func OnSetPP(sender: AnyObject) {
        MBProgressHUD.showHUDAddedTo(self.view, animated: true)
        Post.postPP(newImage) { (success: Bool, error: NSError?)  -> Void in
            if success{
                print("Uploaded PP")
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            }
            if(error != nil){
                print(error?.localizedDescription)
                MBProgressHUD.hideHUDForView(self.view, animated: true)
            }
        }
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
