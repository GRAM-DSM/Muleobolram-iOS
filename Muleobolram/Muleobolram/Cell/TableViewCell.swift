//
//  TableViewCell.swift
//  Muleobolram
//
//  Created by 김기영 on 2021/07/13.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet weak var nameLabel : UILabel!
    @IBOutlet weak var titleLabel : UILabel!
    @IBOutlet weak var view : UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
