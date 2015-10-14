//
//  filterDetailTableViewCell.swift
//  KingPower
//
//  Created by Kamnung Pitukkorn on 9/28/15.
//  Copyright © 2015 IBMSD. All rights reserved.
//

import UIKit

class filterDetailTableViewCell: UITableViewCell {

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var markImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.markImage.hidden = true
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        /*
        if selected == true {
            self.markImage.image = UIImage(named: "check")
        }else{
            self.markImage.image = nil
        }
*/
    }
}
