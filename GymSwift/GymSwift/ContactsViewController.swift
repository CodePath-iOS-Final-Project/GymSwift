//
//  ContactsViewController.swift
//  GymSwift
//
//  Created by Sukhnandan Kaur on 12/17/21.
//

import UIKit
import Parse

class ContactsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var users = [PFObject]()
    var selectedUser = PFUser()

    @IBOutlet weak var tabelView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tabelView.delegate = self
        tabelView.dataSource = self
        
        loadUsers()
    }
    
    func loadUsers() {
        let query = PFUser.query()
        
        query!.findObjectsInBackground { (users, error) in
            if users != nil {
                self.users = users!
                self.tabelView.reloadData()
            }
        }
        
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tabelView.dequeueReusableCell(withIdentifier: "contactCell", for: indexPath as! IndexPath) as! ContactCell
        
        cell.usernameLabel.text = self.users[indexPath.row]["username"] as! String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedUser = self.users[indexPath.row] as! PFUser
        print("selectedUser: \(self.selectedUser)")
        
        self.performSegue(withIdentifier: "usernameSelected", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("preparing...")
        let navVCs = segue.destination as! UINavigationController
        let destinationVC = navVCs.viewControllers[0] as! ChatViewController
        destinationVC.sentToUser = self.selectedUser as! PFUser
    }
    
    

}
