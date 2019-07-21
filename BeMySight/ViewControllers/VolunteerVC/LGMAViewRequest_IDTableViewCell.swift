//
//  LGMAViewRequest_IDTableViewCell.swift
//  BeMySight
//
//  Created by غدير العنزي on 11/07/1440 AH.
//  Copyright © 1440 LGMA. All rights reserved.
//

import UIKit

class LGMAViewRequest_IDTableViewCell: UITableViewCell {
   
    @IBOutlet weak var Place_Name: UILabel!
    
    @IBOutlet weak var Building_Name: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
