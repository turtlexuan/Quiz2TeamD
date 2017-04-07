//
//  ArticleManager.swift
//  Quiz2
//
//  Created by Chujay on 07/04/2017.
//  Copyright © 2017 Chujay. All rights reserved.
//

import UIKit
import CoreData

class ArticleManager {

    static let shared = ArticleManager()

    func save(article: Article) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }

        let context = appDelegate.persistentContainer.viewContext
        let articleData = ArticleMO(context: context)

        guard
            let graphData = UIImagePNGRepresentation(article.graph) as NSData?
            else { return }

        articleData.title = article.title
        articleData.text = article.text
        articleData.graph = graphData

        appDelegate.saveContext()
    }

    typealias RequireArticleCompletion = ([Article]?, Error?) -> Void
    func fetch(_ complettion: RequireArticleCompletion) {

        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
        let context = appDelegate.persistentContainer.viewContext
        let articleRequest: NSFetchRequest<ArticleMO> = ArticleMO.fetchRequest()
        var articleList: [Article] = []

        do {
            let articleData = try context.fetch(articleRequest)
            for data in articleData {

                guard
                    let graphData = data.graph,
                    let title = data.title,
                    let text = data.text,
                    let graph = UIImage(data: graphData as Data)
                    else { return }
                let article = Article(title: title, text: text, graph: graph)
                articleList.append(article)
            }
            complettion(articleList, nil)
        } catch {

            complettion(nil, error)

        }
    }

}
