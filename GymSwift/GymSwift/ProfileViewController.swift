//
//  ProfileViewController.swift
//  GymSwift
//
//  Created by Rebecca Li on 12/17/21.
//

import UIKit
import Parse
import AlamofireImage

class ProfileViewController: UIViewController {
    
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var workoutGoalsDataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        fetchUserInfo()
    }

    func fetchUserInfo(){
        let currentUser = PFUser.current()
        
        let tryImageOpen = currentUser?["profilePic"]
        if tryImageOpen as! NSObject == NSNull() {
            //do nothing
        } else {
            let imageFile = currentUser?["profilePic"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
    
            profileImageView.af.setImage(withURL: url)
        }
        
        let naming = currentUser?["name"] as? String
        if naming == "" {
            nameLabel.text = "Name was not entered at SignUp!"
        }
        else{
            nameLabel.text = naming
        }

        let workouts = currentUser?["workoutGoals"] as? String
        if workouts == "" {
            workoutGoalsDataLabel.text = "Workout Goals empty at SignUp!"
        }
        else{
            workoutGoalsDataLabel.text = workouts
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profileImageView.layer.cornerRadius = profileImageView.frame.size.height/2
        //profilePicture.layer.shouldRasterize = true
        profileImageView.clipsToBounds = true
    }
    
    @IBAction func onSignOutButton(_ sender: Any) {
        PFUser.logOut()
        
        let main = UIStoryboard(name: "Main", bundle: nil)
        let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
        
        delegate.window?.rootViewController = loginViewController
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
