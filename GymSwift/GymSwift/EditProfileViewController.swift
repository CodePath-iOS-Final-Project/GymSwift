//
//  EditProfileViewController.swift
//  GymSwift
//
//  Created by Nirvana Persaud  on 12/9/21.
//

import UIKit

class EditProfileViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBOutlet weak var profilePicture: UIImageView!
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profilePicture.layer.cornerRadius = profilePicture.frame.size.height/2
        //profilePicture.layer.shouldRasterize = true
        profilePicture.clipsToBounds = true
    }
    
    @IBAction func onEditPicButton(_ sender: Any) {
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
        profilePicture.image = image
        //info[.editedImage] as! UIImage
        let size = CGSize(width:300, height:300)
        let scaledImage = image.af.imageScaled(to:size)
        profilePicture.image = scaledImage
        picker.dismiss(animated:true, completion:nil)
        
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated:true, completion: nil)
    }
    


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
