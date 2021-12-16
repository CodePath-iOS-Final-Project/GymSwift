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
    
    //executes 1, 1st thing that happens, called only once - when the view loads
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.rowHeight = UITableView.automaticDimension;
        tableView.estimatedRowHeight = UITableView.automaticDimension;
        
        myRefreshControl.addTarget(self, action: #selector(viewDidAppear(_:)), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
    }
    
    // called everytime view appears
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
    
    //LIFECYCLE
    //viewwillappear: before didappear: what you want it to do(screen)
    //viewwilldisappear: save settings/animations
    //viewdiddisappear: cleanup
    
    func loadMorePosts(){
        let query = PFQuery(className: "Posts")
        query.includeKeys(["author", "comments", "comments.author", "comments.text"])
        query.limit = numberOfPosts + 20
        
        query.findObjectsInBackground {(posts, error) in
            if posts != nil {
                self.posts = posts!
                self.tableView.reloadData()
            }
        }
    }
    
    // if it goes past last cell in screen, do something to display something
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row + 1 == posts.count{
            loadMorePosts()
        }
    }
    
    // customize each row height automatically
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    //how many rows you want [of posts]
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    //customizing each cells - for loop for cells 
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
    }
}
