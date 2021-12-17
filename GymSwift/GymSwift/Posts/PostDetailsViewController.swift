//
//  PostDetailsViewController.swift
//  GymSwift
//
<<<<<<< HEAD
//  Created by Rebecca Li on 11/30/21.
=======
//  Created by Rebecca Li on 11/26/21.
>>>>>>> main
//

import UIKit
import Parse
import AlamofireImage
<<<<<<< HEAD

class PostDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]()
    var selectedPost: PFObject!
    
    var numberOfPosts: Int!
=======
import MessageInputBar

class PostDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedPost: PFObject!
    var comments = [PFObject]()
    
    let commentBar = MessageInputBar()
    var showsCommentBar = false
>>>>>>> main
    
    let myRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
<<<<<<< HEAD
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
    }
    
    //    <Posts: 0x600001c6b600, objectId: cXGocYrqUR, localId: (null)> {
    //        author = "<PFUser: 0x60000165dc00, objectId: xrEnSqTvm4, localId: (null)>";
    //        image = "<PFFileObject: 0x600003715080>";
    //        post = "Nof8. 3 fnoef9s0. F9e f 2093u f9efjs err 3 3 f vivid 0se8v83 ";
    //    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        numberOfPosts = 1
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = numberOfPosts
        
        query.findObjectsInBackground {(posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
                self.myRefreshControl.endRefreshing()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailsCommentCell") as! PostDetailsCommentCell
        let post = selectedPost!
        let user = post["author"] as! PFUser
        
        cell.usernameTopLabel.text = user.username
        cell.usernameBottomLabel.text = user.username
        cell.captionLabel.text = (post["post"] as! String)
        
        let tryImageOpen = post["image"]
        if tryImageOpen as! NSObject == NSNull() {
            return cell
        } else {
            let imageFile = post["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
    
            cell.photoImage.af.setImage(withURL: url)
    
=======
        commentBar.inputTextView.placeholder = "Add a comment ..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self

        comments = selectedPost["comments"] as? [PFObject] ?? []
        
        tableView.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = UITableView.automaticDimension;
    }
    
    @objc func keyboardWillBeHidden(note: Notification){
        commentBar.inputTextView.text = nil
        showsCommentBar = false
        becomeFirstResponder()
    }

    override var inputAccessoryView: UIView?{
        return commentBar
    }
    
    override var canBecomeFirstResponder: Bool{
        return showsCommentBar
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
            return UITableView.automaticDimension
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        let comment = PFObject(className: "Comments")
        
        comment["text"] = text
        comment["post"] = selectedPost
        comment["author"] = PFUser.current()!
        
        selectedPost.add(comment, forKey: "comments")
        selectedPost.saveInBackground{(success, error) in
            if success {
                print("Comment saved")
            } else {
                print("Error! Comment was not saved!")
            }
        }

        commentBar.inputTextView.text = nil
        
        showsCommentBar = false
        becomeFirstResponder()
        commentBar.inputTextView.resignFirstResponder()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count + 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let user = selectedPost["author"] as! PFUser
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailsCommentCell") as! PostDetailsCommentCell

            cell.usernameTopLabel.text = user.username
            cell.usernameBottomLabel.text = user.username
            cell.captionLabel.text = selectedPost["post"] as? String ?? ""
            
            if let imageFile = selectedPost["image"] as? PFFileObject{
                if cell.captionLabel.text == "" {
                    cell.usernameBottomLabel.isHidden = true
                }
                
                let urlString = imageFile.url!
                let url = URL(string: urlString)!
        
                cell.photoImage.af.setImage(withURL: url)
        
                return cell
            }
            else{
                cell.usernameBottomLabel.isHidden = true
                cell.photoImage.removeFromSuperview()
                
                let constraints = [
                    cell.usernameBottomLabel.topAnchor.constraint(equalTo: cell.profileImage.bottomAnchor, constant: 10),
                    cell.captionLabel.topAnchor.constraint(equalTo: cell.profileImage.bottomAnchor, constant: 10),
                ]
                NSLayoutConstraint.activate(constraints)
            }
            return cell
        }
        else if indexPath.row <= comments.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell

            let comment = comments[indexPath.row - 1]
            cell.commentLabel.text = comment["text"] as? String

            let user = comment["author"] as! PFUser
            cell.nameLabel.text = user.username

            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
>>>>>>> main
            return cell
        }
    }
    
<<<<<<< HEAD

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
=======
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = selectedPost!
        let comments = (post["comments"] as? [PFObject]) ?? []

        if indexPath.row == comments.count + 1{
            showsCommentBar = true
            becomeFirstResponder()
            commentBar.inputTextView.becomeFirstResponder()
        }
    }
    
>>>>>>> main

}
