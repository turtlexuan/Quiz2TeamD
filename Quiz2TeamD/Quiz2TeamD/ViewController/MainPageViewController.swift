//
//  MainPageViewController.swift
//  Quiz2TeamD
//
//  Created by 劉仲軒 on 2017/4/7.
//  Copyright © 2017年 劉仲軒. All rights reserved.
//

import UIKit

class MainPageViewController: UIViewController {

    @IBOutlet weak var controllerTitleLabel: UILabel!
    @IBOutlet weak var plusButton: UIButton!
    @IBOutlet weak var tableView: UITableView!

    var article: [Article] = [Article(title: "Hello", content: "World", image: #imageLiteral(resourceName: "Enlight14.jpg"))]

    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "ArticlesTableViewCell", bundle: nil), forCellReuseIdentifier: "ArticlesTableViewCell")
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.rowHeight = 212

        self.plusButton.tintColor = .red
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func newArticleAction(_ sender: Any) {

        guard
            let addArticleBoard = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DetailViewController") as? DetailViewController
            else { return }
        self.navigationController?.pushViewController(addArticleBoard, animated: true)
    }
}

extension MainPageViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
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
    }

}
