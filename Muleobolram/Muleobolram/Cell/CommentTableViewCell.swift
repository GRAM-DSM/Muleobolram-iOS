//
//  CommentTableViewCell.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/15.
//

import UIKit

class CommentTableViewCell: UITableViewCell {
    @IBOutlet weak private var name : UILabel!
    @IBOutlet weak private var detail : UITextView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
