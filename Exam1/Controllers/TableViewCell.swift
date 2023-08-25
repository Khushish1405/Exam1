//
//  TableViewCell.swift
//  Exam1
//
//  Created by APPLE on 16/02/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    @IBOutlet var nameLbl: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
