//
//  ArticlesTableViewCell.swift
//  Quiz2TeamD
//
//  Created by 劉仲軒 on 2017/4/7.
//  Copyright © 2017年 劉仲軒. All rights reserved.
//

import UIKit

class ArticlesTableViewCell: UITableViewCell {

    @IBOutlet weak var articleImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var lineView: UIView!
    @IBOutlet weak var ovalView: UIView!
    @IBOutlet weak var imageBackgroundView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()

        self.ovalView.layer.cornerRadius = self.ovalView.layer.frame.width / 2
        self.ovalView.layer.borderWidth = 1
        self.ovalView.layer.borderColor = Color.borderColor.cgColor

        self.imageBackgroundView.layer.masksToBounds = false
        self.imageBackgroundView.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.imageBackgroundView.layer.shadowOpacity = 0.2
        self.imageBackgroundView.layer.shadowRadius = 5
        self.imageBackgroundView.layer.cornerRadius = 8

        self.articleImageView.layer.cornerRadius = 8
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
