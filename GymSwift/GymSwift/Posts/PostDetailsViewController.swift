//
//  PostDetailsViewController.swift
//  GymSwift
//
//  Created by Rebecca Li on 11/30/21.
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

}
