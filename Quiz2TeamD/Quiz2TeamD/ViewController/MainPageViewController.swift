//
//  MainPageViewController.swift
//  Quiz2TeamD
//
//  Created by 劉仲軒 on 2017/4/7.
//  Copyright © 2017年 劉仲軒. All rights reserved.
//

import UIKit
import CoreData

class MainPageViewController: UIViewController {

    @IBOutlet weak var controllerTitleLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    var article: [Article] = [Article(title: "Hello", content: "World", image: #imageLiteral(resourceName: "icon_photo"))]
    var fetchResultController: NSFetchedResultsController<ArticleMO>!

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "ArticlesTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticlesTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 212

        self.plusButton.tintColor = .red
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        UIApplication.shared.statusBarStyle = .default

        ArticleManager.shared.fetch { (articles, error) in
            if error != nil {
                print(error)
            }

            self.article = articles!
            self.tableView.reloadData()
        }
    }

    @IBAction func newArticleAction(_ sender: Any) {
        // swiftlint:disable force_cast
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.isImageSelected = false
        detailVC.isAddAction = true
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}

extension MainPageViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return article.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let index = self.article[indexPath.row]

        // swiftlint:disable force_cast
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "ArticlesTableViewCell", for: indexPath) as! ArticlesTableViewCell

        cell.titleLabel.text = index.title
        cell.articleImageView.image = index.image

        return cell
    }

}

extension MainPageViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //
        let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.isImageSelected = true
        detailVC.isAddAction = false
        detailVC.article = self.article[indexPath.row]
        detailVC.indexPath = indexPath
        self.navigationController?.pushViewController(detailVC, animated: true)

    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            self.article.remove(at: indexPath.row)

            ArticleManager.shared.deleteArticle(indexPath)

        self.tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }
}
