//
//  TableViewCell.swift
//  SAMPLE TASK
//
//  Created by Toqsoft on 24/05/24.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var Rowid : UILabel!
    @IBOutlet weak var CategoryName : UILabel!
    @IBOutlet weak var Code : UILabel!
    @IBOutlet weak var CreatedBy : UILabel!
    @IBOutlet weak var Admin : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
