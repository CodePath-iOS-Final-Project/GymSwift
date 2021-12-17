//
//  JournalViewController.swift
//  GymSwift
//
//  Created by Nirvana Persaud  on 12/9/21.
//

import UIKit

class JournalViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = models[indexPath.row].title
        cell.detailTextLabel?.text = models[indexPath.row].note
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        tableView.deselectRow(at: indexPath, animated:true)
        
        let model = models[indexPath.row]
        
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "note") as? NoteViewController else{
            return
        }
    vc.navigationItem.largeTitleDisplayMode = .never
    vc.title = "Note"
    vc.noteTitle = model.title
    vc.note = model.note
    navigationController?.pushViewController(vc,animated:true)
    }

    @IBOutlet var table: UITableView!
    @IBOutlet var label: UILabel!
    
    var models: [(title: String, note: String)] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        table.delegate = self
        table.dataSource = self
        title = "Journal"
    
        func didTapNewNote(_ sender: Any) {
            guard let vc=storyboard?.instantiateViewController(withIdentifier: "new") as? EntryViewController else{
                return
            }
            vc.title="New Note"
            vc.navigationItem.largeTitleDisplayMode = .never
            vc.completion = {noteTitle,note in
                self.navigationController?.popToRootViewController(animated: true)
                self.models.append((title:noteTitle, note:note))
                self.label.isHidden = true
                self.table.isHidden = false
                self.table.reloadData()
            }
            navigationController?.pushViewController(vc, animated: true)
            
    }
        // Show note view controller
        guard let vc = storyboard?.instantiateViewController(identifier: "note") as? NoteViewController else{
            return
        }
        vc.title="Note"
        navigationController?.pushViewController(vc, animated:true)
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
