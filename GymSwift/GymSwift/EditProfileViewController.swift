//
//  EditProfileViewController.swift
//  GymSwift
//
//  Created by Nirvana Persaud  on 12/9/21.
//

import UIKit

class EditProfileViewController: UIViewController {

    @IBOutlet weak var profilePicture: UIImageView!
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        profilePicture.layer.cornerRadius = profilePicture.frame.size.height/2
        //profilePicture.layer.shouldRasterize = true
        profilePicture.clipsToBounds = true
    }
    
    @IBAction func onEditPicButton(_ sender: Any) {
        
        
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
