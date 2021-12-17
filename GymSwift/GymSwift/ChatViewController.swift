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
    var sentToUser = PFUser()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("chat vc")
        print("chat user: \(self.sentToUser)")
        tableView.dataSource = self
        tableView.delegate = self
        
        // Ensure dynamic cell size
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 50
        
        loadMessages()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadMessages()
    }
    
    func loadMessages() {
        let query = PFQuery(className:"Message")
        query.whereKey("sentFrom", equalTo: PFUser.current()).whereKey("sentTo", equalTo: self.sentToUser)
    
        
        query.findObjectsInBackground { (messages, error) in
            print("messages: \(messages!)")
            if messages != nil {
                self.parseMessages = messages!
                self.tableView.reloadData()
            }
        }
    }
    
    @IBAction func back(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onSend(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        // Store the text of the text field in a key called text. (Provide a default empty string so message text is never nil)
        chatMessage["text"] = chatMessageField.text ?? ""
        chatMessage["sentFrom"] = PFUser.current()
        chatMessage["sentTo"] = self.sentToUser
        
        //
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                // clear text field on success
                self.chatMessageField.text = ""
                self.loadMessages()
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    @IBOutlet weak var back: UINavigationItem!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return parseMessages.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "chatCell", for: indexPath as IndexPath) as! ChatCell

        
        cell.usernameLabel.text = PFUser.current()?.username as! String
        
//        if let user = parseMessages[indexPath.row]["user"] as? PFUser {
//            // User found! update username label with username
//            cell.usernameLabel.text = user["username"] as! String
//        } else {
//            // No user found, set default username
//            cell.usernameLabel.text = "TJ"
//        }

        cell.messageLabel.text = parseMessages[indexPath.row]["text"] as? String
        
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


