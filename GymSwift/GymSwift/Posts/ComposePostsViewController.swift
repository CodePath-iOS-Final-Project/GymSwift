//
//  ComposePostsViewController.swift
//  GymSwift
//
//  Created by Rebecca Li on 11/18/21.
//

import UIKit
import Parse
import AlamofireImage

class ComposePostsViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var postTextView: UITextView!
    
    @IBAction func onCancelButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSubmitButton(_ sender: Any) {
        let post = PFObject(className: "Posts")
        
        post["post"] = postTextView.text
        post["author"] = PFUser.current()
        
        if (postTextView.text.isEmpty && imageView.image == nil) {
            self.dismiss(animated: true, completion: nil)
            print("text field & image is EMPTY, nothing to save into DB!")
        }
        else if (!postTextView.text.isEmpty && imageView.image == nil){
            post["image"] = NSNull()
            post.saveInBackground { (success, error) in
                if success {
                    self.dismiss(animated: true, completion: nil)
                    print("User entered texts, Post saved with no image!")
                } else {
                    print("Error! Something went wrong!")
                }
            }
        }//end of else-if
        else if (postTextView.text.isEmpty && imageView.image != nil) {
            let imageData:PFFileObject? = getPFFileFromImage(image: imageView.image!)
            if imageData != nil {
                let file = imageData
                post["image"] = file
                
                post.saveInBackground { (success, error) in
                    if success {
                        self.dismiss(animated: true, completion: nil)
                        print("User entered image, Post saved image!")
                    } else {
                        print("Error! Something went wrong!")
                    }
                }
            }
        }
        else{
            let imageData:PFFileObject? = getPFFileFromImage(image: imageView.image!)
            if imageData != nil {
                let file = imageData
                post["image"] = file
                
                post.saveInBackground { (success, error) in
                    if success {
                        self.dismiss(animated: true, completion: nil)
                        print("User entered both text & image, Post saved!")
                    } else {
                        print("Error! Something went wrong!")
                    }
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        postTextView.becomeFirstResponder()
    }
    
    func getPFFileFromImage(image: UIImage?) -> PFFileObject? {
        if let image = image {
            if let imageData = image.pngData() {
                  return PFFileObject(name: "image.png", data: imageData)
            }
        }
        return nil
    }
    
    @IBAction func onCameraButton(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            picker.sourceType = .camera
        } else {
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af.imageAspectScaled(toFill: size)
        
        imageView.image = scaledImage
        dismiss(animated: true, completion: nil)
    }
    

}
