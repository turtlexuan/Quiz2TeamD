//
//  Article.swift
//  Quiz2TeamD
//
//  Created by 劉仲軒 on 2017/4/7.
//  Copyright © 2017年 劉仲軒. All rights reserved.
//

import Foundation
import UIKit

class Article {

    var title: String!
    var content: String!
    var image: UIImage!

    init(title: String, content: String, image: UIImage? = nil) {

        self.title = title
        self.content = content
        self.image = image

    }

}
