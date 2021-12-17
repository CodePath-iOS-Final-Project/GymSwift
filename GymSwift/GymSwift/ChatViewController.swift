//
//  ChatViewController.swift
//  GymSwift
//
//  Created by Sukhnandan Kaur on 12/2/21.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var chatMessageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    var parseMessages: [PFObject] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("In viewDidLoad")

        tableView.dataSource = self
        tableView.delegate = self
        
        // Ensure dynamic cell size
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        
        // Do any additional setup after loading the view.
        // Refresh timer every second to check for messages
    }
    

    @IBAction func onSend(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        // Store the text of the text field in a key called text. (Provide a default empty string so message text is never nil)
        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage["user"] = PFUser.current()
        
        //
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                // clear text field on success
                self.chatMessageField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parseMessages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath as IndexPath) as! ChatCell
//
//        if let user = parseMessages[indexPath.row]["user"] as? PFUser {
//            // User found! update username label with username
//            cell.usernameLabel.text = user.username
//        } else {
//            // No user found, set default username
//            cell.usernameLabel.text = "TJ"
//        }
//
//        cell.messageLabel.text = parseMessages[indexPath.row]["text"] as? String
        
        return cell
    }
}

    /*
     
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */


