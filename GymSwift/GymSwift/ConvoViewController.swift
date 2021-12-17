//
//  ConvoViewController.swift
//  GymSwift
//
//  Created by Sukhnandan Kaur on 12/17/21.
//

import UIKit
import Parse

class ConvoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    

    @IBOutlet weak var tableView: UITableView!
    var convos = [PFObject]()
    var convoUsers = [PFObject]()
    var users = [String]()
    var selectedConvo = PFObject(className: "Message")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        
        loadMessages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadMessages()
    }

    
    func loadMessages() {
        let query = PFQuery(className:"Message")
        query.whereKey("sentFrom", equalTo: PFUser.current())
        query.order(byAscending: "createdAt")
        
        
        query.findObjectsInBackground { (messages, error) in
            if messages != nil {
 
                for convo in messages! {
                    
                    let query2 = PFUser.query()
                    let user = convo["sentTo"] as! PFUser

                    query2?.whereKey("objectId", equalTo: user.objectId)
                    
                    query2?.findObjectsInBackground { (userInfo, error) in
                        if userInfo != nil {
                            let thisUser = userInfo![0]
                            print(self.users)
                            if self.users.contains(thisUser.objectId!) {
                                print("here")
                            } else {
                                self.convos.append(convo as! PFObject)
                                self.users.append(thisUser.objectId!)
                                //self.convoUsers.append(thisUser)
                                self.convoUsers.append(thisUser as! PFUser)
                            }
                            self.tableView.reloadData()                        }
                    }
                    
                    
                }
                
                
                
            }
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.convos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "convoCell", for: indexPath as IndexPath) as! ConvoCell
        
        let convo = self.convos[indexPath.row]
        let user = self.convoUsers[indexPath.row]
        cell.usernameLabel.text = user["username"] as! String
        cell.messageLabel.text = convo["text"] as! String
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        self.selectedConvo = self.convos[indexPath.row]
        self.performSegue(withIdentifier: "convoSelected", sender: nil)

    }
    
    
    @IBAction func newConvo(_ sender: Any) {
        performSegue(withIdentifier: "newConvo", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "newConvo" {
            print("going to newConvo")
        } else {
            let navVCs = segue.destination as! UINavigationController
            let destinationVC = navVCs.viewControllers[0] as! ChatViewController
            destinationVC.sentToUser = self.selectedConvo["sentTo"] as! PFUser
            
        }
        
        
    }

}
