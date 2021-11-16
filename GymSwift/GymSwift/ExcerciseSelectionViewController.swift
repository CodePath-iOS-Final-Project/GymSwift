//
//  ExcerciseSelectionViewController.swift
//  GymSwift
//
//  Created by Sukhnandan Kaur on 11/15/21.
//

import TTGTags
import UIKit
import Parse

class ExcerciseSelectionViewController: UIViewController {

   // let collectionView = TTGTextTagCollectionView()
   // var tags = [TTGTextTag]()
    
    private var selections = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tagView = TTGTextTagCollectionView.init(frame: CGRect.init(x: 16, y: 150, width: UIScreen.main.bounds.width - 32, height: 300))
        self.view.addSubview(tagView)
        
        tagView.alignment = .center
        
        
        let strings = ["Running", "Jogging", "Tennis", "Basketball", "Biking", "Gym", "Swimming", "Walking", "Bowling", "Yoga", "Skateboarding", "Soccer", "Football", "Volleyball", "Hiking", "Dancing", "Boxing", "Badminton"]
        
        for text in strings {
            let content = TTGTextTagStringContent.init(text: text)
            content.textColor = UIColor.black
            content.textFont = UIFont.boldSystemFont(ofSize: 17)
            
            let normalStyle = TTGTextTagStyle.init()
            normalStyle.backgroundColor = UIColor.white
            normalStyle.extraSpace = CGSize.init(width: 15, height: 15)
            
            let selectedStyle = TTGTextTagStyle.init()
            selectedStyle.backgroundColor = UIColor.systemTeal
            selectedStyle.extraSpace = CGSize.init(width: 15, height: 15)
            
            let tag = TTGTextTag.init()
            tag.content = content
            tag.style = normalStyle
            tag.selectedStyle = selectedStyle
            
            tagView.addTag(tag)
            
        }
        tagView.reload()
    }
    func textTagCollectionView(_ textTagCollectionView: TTGTextTagCollectionView!, didTapTag tagText: String!, at index: UInt, selected: Bool, tagView : TTGTextTagStringContent!) {
        selections.append(tagText)
        
        print("\(selections)")
}

}
