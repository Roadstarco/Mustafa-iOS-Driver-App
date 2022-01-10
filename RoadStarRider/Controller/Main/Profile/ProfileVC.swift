//
//  ProfileVC.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/5/28.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SDWebImage

class ProfileVC: BaseViewController, Storyboarded {
    
    @IBOutlet weak var txtEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var txtSecName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtFirstName: SkyFloatingLabelTextField!
    @IBOutlet weak var btnImgProfile: UIButton!
    @IBOutlet weak var imgProfile: UIImageView!
    
    // MARK: Private Functions
    var imagePicker: ImagePicker!
    var imgChanged: Bool = false
    var mobile: String = ""
    
    override func setupUI() {
        
        let firstName = UserSession.shared.user?.firstName ?? ""
        let secondName = UserSession.shared.user?.lastName ?? ""
        let email = UserSession.shared.user?.email ?? ""
        let mobile = UserSession.shared.user?.mobile ?? ""
        let profileImg = UserSession.shared.user?.avatar ?? ""
        txtFirstName.text = firstName
        txtSecName.text = secondName
        txtEmail.text = email
        self.mobile = mobile
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        
        
        if let url = URL(string: profileImg) {
            imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgProfile.sd_setImage(with: url)
        }
    }
    
    @IBAction func btnSettingTapped(_ sender: Any) {
        let vc = SettingsVC.instantiateMain()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    @IBAction func btnImgProfileTapped(_ sender: UIButton) {
        self.imagePicker.present(from: sender, showCamera: true, showLibrary: true)
    }
    
    @IBAction func btnUpdateProfileTapped(_ sender: Any) {
        
        if isValidate() {
            self.updateProfile { (msg, success) in
                
                if success {
                    Toast.show(message: "Successfully Updated.")
                }
            }
        }
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        
        
    }
    
    func isValidate() -> Bool {
        
        if txtEmail.text == nil {
            Toast.showError(message: "Email field is empty")
            return false
        } else if txtEmail.text!.isEmpty {
            Toast.showError(message: "Email field is empty")
            return false
        } else if txtFirstName.text == nil {
            Toast.showError(message: "First Name field is empty")
            return false
        } else if txtFirstName.text!.isEmpty {
            Toast.showError(message: "First Name field is empty")
            return false
        } else if txtSecName.text == nil {
            Toast.showError(message: "Second Name field is empty")
            return false
        } else if txtSecName.text!.isEmpty {
            Toast.showError(message: "Second Name field is empty")
            return false
        }
        return true
        
    }
}


extension ProfileVC {
    
    func updateProfile(block: @escaping (String?, Bool)-> Void){
        
        let fName = txtFirstName.text!
        let sName = txtSecName.text!
        let email = txtEmail.text!
        
        var data: UploadData? = nil
        if imgChanged {
            data = UploadData(data: imgProfile.image!.pngData()!, fileName: "\(Date().timeIntervalSince1970).png", mimeType: "png", name: "avatar")
        }
        let pi = ProgressIndicator.show(message: "loading...")
        
        TheRoute.updateProfile(firstName: fName, secName: sName, email: email, mobile: self.mobile).send(ProfileUpdatedResponse.self, data: data, multipleData: nil) { (progress) in
            print(progress)
        } then: { (results) in
            pi.close()
            switch results {
            case .failure(let error):
                print(error)
                block(error.localizedDescription, false)
                
                
            case .success(let data ):
                print(data)
                
                var us = UserSession.shared.user
                if let fName = data.firstName {
                    us?.firstName = fName
                }
                if let sName = data.lastName {
                    us?.lastName = sName
                }
                if let email = data.email {
                    us?.email = email
                }
                if let img = data.avatar {
                    us?.avatar = img
                    
                }
                UserSession.shared.user = us
                
                block(nil, true)
            }
        }
    }
    
    
}


extension ProfileVC: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        
        if let img = image {
            imgChanged = true
            self.imgProfile.image = img
        }
    }
    
    func didSelect(videoUrl: NSURL?) {
    }
}
