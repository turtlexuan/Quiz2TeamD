//
//  Article.swift
//  Quiz2
//
//  Created by Chujay on 07/04/2017.
//  Copyright © 2017 Chujay. All rights reserved.
//

import UIKit

struct Article {
    let title: String
    let text: String!
    let graph: UIImage!

    init(title: String, text: String, graph: UIImage) {
        self.title = title
        self.text = text
        self.graph = graph
    }
}
