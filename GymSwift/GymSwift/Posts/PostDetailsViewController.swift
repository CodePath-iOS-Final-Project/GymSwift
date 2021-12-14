//
//  PostDetailsViewController.swift
//  GymSwift
//
//  Created by Rebecca Li on 11/26/21.
//

import UIKit
import Parse
import AlamofireImage
import MessageInputBar

class PostDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, MessageInputBarDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var selectedPost: PFObject!
    var comments = [PFObject]()
    
    let commentBar = MessageInputBar()
    var showsCommentBar = false
    
    let myRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        commentBar.inputTextView.placeholder = "Add a comment ..."
        commentBar.sendButton.title = "Post"
        commentBar.delegate = self
        
        tableView.delegate = self
        tableView.dataSource = self

        comments = selectedPost["comments"] as? [PFObject] ?? []
        
        //dismiss keyboard by dragging it down the tableview
        tableView.keyboardDismissMode = .interactive
        
        let center = NotificationCenter.default
        center.addObserver(self, selector: #selector(keyboardWillBeHidden(note:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
//        print(selectedPost!)
//        print("inside post[comments]?")
//        print(comments)
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
    
    // details view = 1 section; 1 row = just a post, 1 row = comment...
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    @objc func messageInputBar(_ inputBar: MessageInputBar, didPressSendButtonWith text: String) {
        // create the comment
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
        
        //need to reload comments sections ---------------------------------------------

        
        
        //clear and dismiss the input bar
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
            cell.captionLabel.text = (selectedPost["post"] as! String)
            
            let tryImageOpen = selectedPost["image"]
            //if image does not exist...
            if tryImageOpen as! NSObject == NSNull() {
                cell.photoImage.removeFromSuperview()
                cell.photoImage.image = nil
                return cell
            } else {
                //if image exists...
                let imageFile = selectedPost["image"] as! PFFileObject
                let urlString = imageFile.url!
                let url = URL(string: urlString)!
        
                cell.photoImage.af.setImage(withURL: url)
        
                return cell
            }
        }
        else if indexPath.row <= comments.count {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell

            // configure to show comments
            let comment = comments[indexPath.row - 1]
            cell.commentLabel.text = comment["text"] as? String

            let user = comment["author"] as! PFUser
            cell.nameLabel.text = user.username

            return cell
        }
        else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddCommentCell")!
            return cell
        }
    }//end of func
    
    // click on image to generate a comment
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = selectedPost!
        let comments = (post["comments"] as? [PFObject]) ?? []

        if indexPath.row == comments.count + 1{
            showsCommentBar = true
            becomeFirstResponder()
            commentBar.inputTextView.becomeFirstResponder()
        }
    }
    

}
