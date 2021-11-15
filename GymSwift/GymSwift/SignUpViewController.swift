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
        //placeholder Test for -> Excercise Selection Screen
        let user = PFUser()
        user.username = usernameField.text
        user.password = passwordField.text
        user["name"] = nameField.text
        user["workoutGoals"] = workoutGoalsField.text
        //PLACEHOLDER FOR Excercise Selection Screen!!!
        user.signUpInBackground { (success, error) in
            if success {
                self.performSegue(withIdentifier: "signupSegue", sender: nil)
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
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
