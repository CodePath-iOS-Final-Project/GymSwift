//
//  NoteViewController.swift
//  GymSwift
//
//  Created by Nirvana Persaud  on 12/17/21.
//

import UIKit

class NoteViewController: UIViewController {
    
    @IBOutlet var titleLabel: UILabel!
    @IBOutlet var noteLabel: UITextView!

    public var noteTitle:String = " "
    public var note: String = " "
    
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLabel.text = noteTitle
        noteLabel.text = note

        // Do any additional setup after loading the view.
    }
    

}
