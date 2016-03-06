//
//  HomeCell.swift
//  codepath-insta
//
//  Created by Gautam Sadarangani on 3/5/16.
//  Copyright © 2016 Gautam Sadarangani. All rights reserved.
//

import UIKit

class HomeCell: UITableViewCell {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var postImage: UIImageView!
    @IBOutlet weak var profileView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
