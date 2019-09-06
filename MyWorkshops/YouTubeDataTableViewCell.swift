//
//  YouTubeDataTableViewCell.swift
//  MyWorkshops
//
//  Created by INVISION on 18/8/2562 BE.
//  Copyright © 2562 INVISION. All rights reserved.
//

import UIKit

class YouTubeDataTableViewCell: UITableViewCell {

    @IBOutlet weak var mTitleLable: UILabel!
    @IBOutlet weak var mSubtitleLable: UILabel!
    @IBOutlet weak var mAvatarImageView: UIImageView!
    @IBOutlet weak var mYoutubeImageView: UIImageView!
    @IBOutlet weak var mCardView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.mAvatarImageView.drawAsCircle()
        self.mCardView.drawAsCircle(radius: 5)
        self.mYoutubeImageView.drawAsCircle(radius: 5)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
