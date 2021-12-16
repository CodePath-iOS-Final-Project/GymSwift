//
//  PostDetailsCommentCell.swift
//  GymSwift
//
//  Created by Rebecca Li on 11/26/21.
//

import UIKit

class PostDetailsCommentCell: UITableViewCell {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernameTopLabel: UILabel!
    @IBOutlet weak var usernameBottomLabel: UILabel!
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var captionLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
