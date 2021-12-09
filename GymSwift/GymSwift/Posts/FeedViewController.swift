//
//  FeedViewController.swift
//  GymSwift
//
//  Created by Rebecca Li on 11/19/21.
//

import UIKit
import Parse
import AlamofireImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var posts = [PFObject]()
    var numberOfPosts: Int!
    
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = UITableView.automaticDimension;
        
        myRefreshControl.addTarget(self, action: #selector(viewDidAppear(_:)), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        numberOfPosts = 20
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
    
    func loadMorePosts(){
        let query = PFQuery(className: "Posts")
        query.includeKey("author")
        query.limit = numberOfPosts + 20
        
        query.findObjectsInBackground {(posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == posts.count{
            loadMorePosts()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell") as! PostCell
        let post = posts[indexPath.row]
        let user = post["author"] as! PFUser
        
        cell.usernameLabel.text = user.username
        cell.postsCaptionLabel.text = post["post"] as? String
        
        let tryImageOpen = post["image"]
        if tryImageOpen as! NSObject == NSNull() {
            return cell
        } else {
            let imageFile = post["image"] as! PFFileObject
            let urlString = imageFile.url!
            let url = URL(string: urlString)!
    
            cell.photoView.af.setImage(withURL: url)
    
            return cell
        }
    }
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    
    //use segue identifier
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        if segue.identifier == "moreDetailsSegue" {
            let cell = sender as! UITableViewCell
            let indexPath = tableView.indexPath(for: cell)!

            let post = posts[indexPath.row]
            let postDetailsViewController = segue.destination as! PostDetailsViewController
            postDetailsViewController.selectedPost = post

            tableView.deselectRow(at: indexPath, animated: true)
        }
        else{
//            performSegue(withIdentifier: "createPostSegue", sender: self)
            print("nothing")
        }
    }
}
