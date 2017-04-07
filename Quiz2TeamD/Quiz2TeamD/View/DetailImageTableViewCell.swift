//
//  DetailImageTableViewCell.swift
//  Quiz2TeamD
//
//  Created by 劉仲軒 on 2017/4/7.
//  Copyright © 2017年 劉仲軒. All rights reserved.
//

import UIKit

class DetailImageTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.articleImageView.tintColor = .white
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
