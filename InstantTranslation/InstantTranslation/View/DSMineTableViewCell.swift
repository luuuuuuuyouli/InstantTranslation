//
//  DSMineTableViewCell.swift
//  DriverSubscribe
//
//  Created by syong on 2020/3/20.
//  Copyright © 2020 com.eios. All rights reserved.
//

import UIKit

class DSMineTableViewCell: UITableViewCell {

    @IBOutlet weak var pic: UIImageView!
    
    @IBOutlet weak var titleL: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
