//
//  JournalViewController.swift
//  GymSwift
//
//  Created by Nirvana Persaud  on 12/9/21.
//

import UIKit

class JournalViewController: UIViewController {
    
    @IBOutlet var table: UITableView!
    @IBOutlet var label: UILabel!
    
    var models: [(title: String, note: String)] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //table.delegate = self
        //table.dataSource = self
        title = "Notes"
        
    

        // Do any additional setup after loading the view.
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
