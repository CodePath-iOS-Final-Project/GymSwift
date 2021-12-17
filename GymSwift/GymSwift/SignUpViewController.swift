//
//  SignUpViewController.swift
//  GymSwift
//
//  Created by Rebecca Li on 11/12/21.
//

import UIKit
import Parse

class SignUpViewController: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var workoutGoalsField: UITextField!
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2
        //profilePicture.layer.shouldRasterize = true
        profileImageView.clipsToBounds = true
    }
    
    @IBAction func onAddButton(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        let actionSheet = UIAlertController(title: "Choose a source", message: nil, preferredStyle: .
        actionSheet)
        
        
        actionSheet.addAction(UIAlertAction(title:"Camera", style: .default, handler: { UIAlertAction in
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        }))
        
        actionSheet.addAction(UIAlertAction(title:"Photo Library", style: .default, handler: { UIAlertAction in
            imagePickerController.sourceType = .photoLibrary
            self.present(imagePickerController, animated: true, completion: nil)
        }))
            
        actionSheet.addAction(UIAlertAction(title:"Cancel", style: .cancel, handler: nil))
        self.present(actionSheet, animated: true, completion:nil)
        imagePickerController.allowsEditing = true
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[UIImagePickerController.InfoKey.originalImage] as! UIImage
        profileImageView.image = image
        //info[.editedImage] as! UIImage
        let size = CGSize(width:300, height:300)
        let scaledImage = image.af.imageScaled(to:size)
        profileImageView.image = scaledImage
        picker.dismiss(animated:true, completion:nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:true, completion: nil)
    }

    @IBAction func nextButton(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user["name"] = nameField.text
        user["workoutGoals"] = workoutGoalsField.text
        
        if (profileImageView.image == nil) {
            user["profilePic"] = NSNull()
            print("profile image is empty!")
            user.signUpInBackground { (success, error) in
                if success {
                    self.performSegue(withIdentifier: "exerciseSegue", sender: nil)
                }
                else{
                    print("Error: \(error?.localizedDescription)")
                }
            }
        }else{
            let imageData = profileImageView.image!.pngData()
            let file = PFFileObject(data: imageData!)
            user["profilePic"] = file
            user.signUpInBackground { (success, error) in
                if success {
                    self.performSegue(withIdentifier: "exerciseSegue", sender: nil)
                }
                else{
                    print("Error: \(error?.localizedDescription)")
                }
            }
        }

    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}
