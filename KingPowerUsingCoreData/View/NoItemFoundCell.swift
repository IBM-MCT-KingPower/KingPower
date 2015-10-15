//
//  noTableFoundCell.swift
//  KingPowerUsingCoreData
//
//  Created by Kewalin Sakawattananon on 10/15/2558 BE.
//  Copyright © 2558 IBM. All rights reserved.
//

import UIKit

class NoItemFoundCell: UITableViewCell {
    @IBOutlet weak var lblNoItemFound: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
}
