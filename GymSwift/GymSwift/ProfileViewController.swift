//
//  ProfileViewController.swift
//  GymSwift
//
//  Created by Nirvana Persaud  on 12/9/21.
//

import UIKit
import Parse

class ProfileViewController: UIViewController {

    @IBOutlet weak var profilePicture: UIImageView!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profilePicture.layer.cornerRadius = profilePicture.frame.size.height/2
        //profilePicture.layer.shouldRasterize = true
        profilePicture.clipsToBounds = true
    }
    
    
    @IBAction func onSignOutButton(_ sender: Any) {
    PFUser.logOut()
    let main = UIStoryboard(name: "Main", bundle: nil)
    let loginViewController = main.instantiateViewController(withIdentifier: "LoginViewController")
    guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene, let delegate = windowScene.delegate as? SceneDelegate else { return }
    
    delegate.window?.rootViewController = loginViewController
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
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
