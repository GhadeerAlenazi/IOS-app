//
//  LGMAHomeeViewControllr.swift
//  BeMySight
//
//  Created by غدير العنزي on 11/07/1440 AH.
//  Copyright © 1440  LGMA. All rights reserved.
//

import Foundation
import Foundation
import UIKit

class LGMAHomeeViewController: UITableViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var usernamelabel: UILabel!
    @IBOutlet weak var userEmailLabel: UILabel!
    @IBOutlet weak var pointlabel: UILabel!
    
    override func viewDidLoad() {
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cofigureView()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    @IBAction func onImageChange(_ sender: UIButton) {
        let selectImage = UIImagePickerController()
        selectImage.delegate = self
        selectImage.sourceType  = UIImagePickerController.SourceType.photoLibrary
        self.present(selectImage, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any])
    {
        // Set the original image to show.
        guard let selectedImage = info[.originalImage] as? UIImage else {
            fatalError("Expected a dictionary containing an image, but was provided the following: \(info)")
        }
        // Set profileImage to display the selected image.
        profileImage.image = selectedImage
        
        // Dismiss the picker.
        dismiss(animated: true, completion: nil)
        
        // Save selected Image to UserDefault.
        if let imageData = profileImage.image?.jpegData(compressionQuality: 0.75) {
            UserDefaults.standard.set(imageData, forKey: "userImage")
        }
    }
    
    func cofigureView() {
        if let imageDate = UserDefaults.standard.data(forKey: "userImage") {
            profileImage.image = UIImage(data: imageDate)
        }
        
        let username = UserDefaults.standard.string(forKey: "username")
            let point = UserDefaults.standard.string(forKey: "point")
            let email = UserDefaults.standard.string(forKey: "email")
            
            self.usernamelabel.text = username
     
            self.userEmailLabel.text = email
            self.pointlabel.text = point
     //   print(point)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "changeUsername" {
            let editorVC = segue.destination as! LGMAEditViewController
            editorVC.selectedCell = 1
            
        } else if segue.identifier == "changeEmail" {
            let editorVC = segue.destination as! LGMAEditViewController
            editorVC.selectedCell = 2
        }
    }
}

