//
//  sortTableViewCell.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 9/26/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import UIKit

class sortTableViewCell: UITableViewCell {

    @IBOutlet weak var markImage: UIImageView!
    @IBOutlet weak var menuLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.markImage.hidden = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
