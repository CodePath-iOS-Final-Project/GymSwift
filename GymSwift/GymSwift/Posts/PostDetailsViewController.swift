//
//  PostDetailsViewController.swift
//  GymSwift
//
//  Created by Rebecca Li on 11/26/21.
//

import UIKit
import Parse
import AlamofireImage

class PostDetailsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]()
    var selectedPost: PFObject!
    
    var numberOfPosts: Int!
    
    let myRefreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self

        // Do any additional setup after loading the view.
        let post = selectedPost!
        let comments = post["comments"]

        print(selectedPost!)
        print("inside post[comments]?")
        print(comments!)
    }
    
//    <Posts: 0x600001c6b600, objectId: cXGocYrqUR, localId: (null)> {
//        author = "<PFUser: 0x60000165dc00, objectId: xrEnSqTvm4, localId: (null)>";
//        image = "<PFFileObject: 0x600003715080>";
//        post = "Nof8. 3 fnoef9s0. F9e f 2093u f9efjs err 3 3 f vivid 0se8v83 ";
//    }
//    inside post[comments]?
//    (
//        "<Comments: 0x60000198d560, objectId: b2f1seIEiv, localId: (null)> {\n}",
//        "<Comments: 0x60000198d500, objectId: 1iAoxL5svU, localId: (null)> {\n}",
//        "<Comments: 0x60000198cf60, objectId: n9GBUm7cf7, localId: (null)> {\n}",
//        "<Comments: 0x60000198cfc0, objectId: RIfHm3tY8H, localId: (null)> {\n}",
//        "<Comments: 0x60000198d020, objectId: 3sl2NpN7xo, localId: (null)> {\n}",
//        "<Comments: 0x60000198d080, objectId: opcr6asYJv, localId: (null)> {\n}",
//        "<Comments: 0x60000198d0e0, objectId: mmutJ9jgiH, localId: (null)> {\n}",
//        "<Comments: 0x60000198d140, objectId: nE8SlgttqC, localId: (null)> {\n}",
//        "<Comments: 0x60000198d1a0, objectId: rdgQniOmR6, localId: (null)> {\n}",
//        "<Comments: 0x60000198d200, objectId: Y4CukvDWU3, localId: (null)> {\n}",
//        "<Comments: 0x60000198d380, objectId: zshQ3UVikJ, localId: (null)> {\n}",
//        "<Comments: 0x60000198cea0, objectId: mQ2GMfxjuH, localId: (null)> {\n}"
//    )
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
//        numberOfPosts = 1
        let query = PFQuery(className: "Posts")
        query.includeKeys(["author", "comments", "comments.author", "comments.text"])
//        query.limit = numberOfPosts
        
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
        let post = posts[section]
        let comments = (post["comments"] as? [PFObject]) ?? []
//        return posts.count
        return comments.count + 1
//        return 1
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let post = selectedPost!
//        let post = posts[indexPath.section]
        let comments = (post["comments"] as? [PFObject]) ?? []
//        let comments = post["comments"] as? [PFObject]
        print(post["comments.text"])
        print(post["comments"]!)
        let user = post["author"] as! PFUser
        
//        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PostDetailsCommentCell") as! PostDetailsCommentCell
            
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
        
                return cell
            }
//        }
//        else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
//
//            // configure to show comments
//            let comment = comments[indexPath.row - 1]
////            cell.commentLabel.text = comment["text"] as? String
//
//            let user = comment["author"] as! PFUser
//            cell.nameLabel.text = user.username
//
//            return cell
//        }
    }//end of func
    
    // details view = 1 section; 1 row = jsut a post, 1 row = comment...
    func numberOfSections(in tableView: UITableView) -> Int {
        return posts.count
    }
    
    // click on image to generate a comment
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let post = posts[indexPath.row]
        let comment = PFObject(className: "Comments")
        
        comment["text"] = "Random pushed comment"
        comment["post"] = post
        comment["author"] = PFUser.current()!
        
        post.add(comment, forKey: "comments")
        post.saveInBackground{(success, error) in
            if success {
                print("Comment saved")
            } else {
                print("Error! Comment was not saved!")
            }
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

}
