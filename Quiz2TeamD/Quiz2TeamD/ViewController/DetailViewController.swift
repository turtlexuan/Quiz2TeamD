//
//  DetailViewController.swift
//  Quiz2TeamD
//
//  Created by 劉仲軒 on 2017/4/7.
//  Copyright © 2017年 劉仲軒. All rights reserved.
//

import UIKit
import DKImagePickerController

class DetailViewController: UIViewController {

    enum Component {

        case image, title, content

    }

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var saveButton: UIButton!

    var component: [Component] = [.image, .title, .content]
    var image: UIImage = #imageLiteral(resourceName: "icon_photo")
    var height: CGFloat = 56

    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarStyle = .lightContent

        self.tableView.delegate = self
        self.tableView.dataSource = self

        self.saveButton.layer.masksToBounds = false
        self.saveButton.layer.shadowOffset = CGSize(width: 0, height: 0)
        self.saveButton.layer.shadowOpacity = 0.2
        self.saveButton.layer.shadowRadius = 5
        self.saveButton.layer.cornerRadius = self.saveButton.layer.frame.height / 2

        self.tableView.register(UINib(nibName: "DetailImageTableViewCell", bundle: nil), forCellReuseIdentifier: "DetailImageTableViewCell")
        self.tableView.register(UINib(nibName: "TitleTableViewCell", bundle: nil), forCellReuseIdentifier: "TitleTableViewCell")
        self.tableView.register(UINib(nibName: "TextTableViewCell", bundle: nil), forCellReuseIdentifier: "TextTableViewCell")
        self.tableView.estimatedRowHeight = 150
    }

    @IBAction func saveAction(_ sender: Any) {
    }
    
    func showImagePickerAlertSheet() {
        let alertController = UIAlertController(title: "Choose Image From?", message: nil, preferredStyle: .actionSheet)
        
        let libraryAction = UIAlertAction(title: "Choose from photo library", style: .default) { (_) in
            
//            let pickerController = UIImagePickerController()
//            pickerController.allowsEditing = false
//            pickerController.sourceType = .photoLibrary
//            
//            self.present(pickerController, animated: true, completion: nil)
            
            let pickerController = DKImagePickerController()
            pickerController.assetType = .allPhotos
            pickerController.maxSelectableCount = 1
            pickerController.didSelectAssets = { [unowned self] (assets: [DKAsset]) in
                print("didSelectAssets")
                
                let asset = assets.first
                asset?.fetchOriginalImage(true, completeBlock: { (imageData, _) in
                    guard let image = imageData else { return }
                    self.image = image
                    self.tableView.reloadData()
                })
            }
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let cameraAction = UIAlertAction(title: "Take a photo", style: .default) { (_) in
            
            let pickerController = DKImagePickerController()
            pickerController.sourceType = .camera
            
            pickerController.didSelectAssets = { [unowned self] (assets: [DKAsset]) in
                print("didSelectAssets")
                
                let asset = assets.first
                asset?.fetchOriginalImage(true, completeBlock: { (imageData, _) in
                    guard let image = imageData else { return }
                    self.image = image
                    self.tableView.reloadData()
                })
            }
            self.present(pickerController, animated: true, completion: nil)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        
        alertController.addAction(libraryAction)
        alertController.addAction(cameraAction)
        alertController.addAction(cancelAction)
        
        self.present(alertController, animated: true, completion: nil)
    }
}

extension DetailViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        switch self.component[indexPath.row] {
        case .image:
            // swiftlint:disable force_cast
            let cell = self.tableView.dequeueReusableCell(withIdentifier: "DetailImageTableViewCell", for: indexPath) as! DetailImageTableViewCell

            cell.selectionStyle = .none
            
//            let tintedImage = self.image.withRenderingMode(.alwaysTemplate)
//            cell.articleImageView.image = tintedImage
            cell.articleImageView.image = self.image
            cell.articleImageView.contentMode = .scaleAspectFill
            cell.articleImageView.clipsToBounds = true

            return cell

        case .title:

            let cell = self.tableView.dequeueReusableCell(withIdentifier: "TitleTableViewCell", for: indexPath) as! TitleTableViewCell

            cell.selectionStyle = .none
            
            return cell

        case .content:

            let cell = self.tableView.dequeueReusableCell(withIdentifier: "TextTableViewCell", for: indexPath) as! TextTableViewCell
            
            cell.selectionStyle = .none
            
            cell.textField.delegate = self

            return cell
        }

    }

}

extension DetailViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {

        switch self.component[indexPath.row] {
        case .image:
            return self.tableView.frame.width

        case .title:
            return 56

        case .content:
            return UITableViewAutomaticDimension
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if self.component[indexPath.row] == .image {
            self.showImagePickerAlertSheet()
        }
    }

}

extension DetailViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        let currentOffset = self.tableView.contentOffset
        UIView.setAnimationsEnabled(false)
        self.tableView.beginUpdates()
        self.tableView.endUpdates()
        UIView.setAnimationsEnabled(true)
        self.tableView.setContentOffset(currentOffset, animated: false)
    }
}

//extension DetailViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
//    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        
//        if let selectedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            self.image = selectedImage
//            self.tableView.reloadData()
//        }
//        
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//}


