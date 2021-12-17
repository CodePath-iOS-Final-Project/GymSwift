//
//  SignUpViewController.swift
//  GymSwift
//
//  Created by Rebecca Li on 11/12/21.
//

import UIKit
import Parse

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var addProfilePicField: UILabel!
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var workoutGoalsField: UITextField!


    @IBAction func nextButton(_ sender: Any) {
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user["name"] = nameField.text
        user["workoutGoals"] = workoutGoalsField.text
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "exerciseSegue", sender: nil)
            }
            else{
                print("Error: \(error?.localizedDescription)")
            }
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

}
