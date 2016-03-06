//
//  Post.swift
//  codepath-insta
//
//  Created by Gautam Sadarangani on 3/5/16.
//  Copyright © 2016 Gautam Sadarangani. All rights reserved.
//

import UIKit
import Parse

class Post: NSObject {
    
    var image: UIImageView?
    var caption: String = ""
    var author: PFUser?
    var likesCount: Int?
    
    class func postPP(image: UIImage?, withCompletion completion: PFBooleanResultBlock?){
        let picture = PFObject(className: "ProfilePictures")
        picture["media"] = getPFFileFromImage(image)
        picture["username"] = PFUser.currentUser()?.username
        picture["author"] = PFUser.currentUser()
        picture.saveInBackgroundWithBlock(completion)
    }
    
    class func postUserImage(image: UIImage?, withCaption caption: String?, withCompletion completion: PFBooleanResultBlock?) {
        // Create Parse object PFObject
        let post = PFObject(className: "Post")
        
        // Add relevant fields to the object
        post["media"] = getPFFileFromImage(image) // PFFile column type
        post["author"] = PFUser.currentUser() // Pointer column type that points to PFUser
        post["caption"] = caption
        post["likesCount"] = 0
        post["username"] = PFUser.currentUser()?.username
       
       // post["commentsCount"] = 0
        
        // Save object (following function will save the object in Parse asynchronously)
        post.saveInBackgroundWithBlock(completion)
    }

    class func getPFFileFromImage(image: UIImage?) -> PFFile? {
        // check if image is not nil
        if let image = image {
            // get image data and check if that is not nil
            if let imageData = UIImagePNGRepresentation(image) {
                return PFFile(name: "image.png", data: imageData)
            }
        }
        return nil
    }

}
