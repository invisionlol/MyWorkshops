//
//  CustomTableViewCell.swift
//  MyWorkshops
//
//  Created by INVISION on 24/8/2562 BE.
//  Copyright © 2562 INVISION. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mFlightLabel: UILabel!
    @IBOutlet weak var mFlightImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
    
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }

}
