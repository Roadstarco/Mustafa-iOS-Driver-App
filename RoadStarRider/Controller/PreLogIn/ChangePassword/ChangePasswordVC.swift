//
//  ChangePasswordVC.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/5/30.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class ChangePasswordVC: BaseViewController, Storyboarded {
    
    @IBOutlet weak var txtOldPass: SkyFloatingLabelTextField!
    @IBOutlet weak var txtPass: SkyFloatingLabelTextField!
    @IBOutlet weak var txtConfPass: SkyFloatingLabelTextField!
    
    override func setupUI() {
        
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnSaveTapped(_ sender: UIButton) {
        
        if isValidate() {
            self.updatePassword { (msg, success) in
                
                if success {
                    Toast.show(message: "Successfully Updated Password.")
                    var redirect : RedirectHelper!
                    redirect = RedirectHelper(window: nil)
                    redirect.determineRoutes()
                } else {
                    Toast.show(message: msg ?? "Something went wrong!")
                }
            }
        }
        
    }
    
    func isValidate() -> Bool {
        
        if txtOldPass.text == nil {
            Toast.showError(message: "Old Pass field is empty")
            return false
        } else if txtOldPass.text!.isEmpty {
            Toast.showError(message: "Old Pass field is empty")
            return false
        } else if txtPass.text == nil {
            Toast.showError(message: "Password field is empty")
            return false
        } else if txtPass.text!.isEmpty {
            Toast.showError(message: "Password field is empty")
            return false
        } else if txtConfPass.text == nil {
            Toast.showError(message: "Conf Password field is empty")
            return false
        } else if txtConfPass.text!.isEmpty {
            Toast.showError(message: "Conf Password field is empty")
            return false
        } else if txtConfPass.text! != txtPass.text! {
            Toast.showError(message: "Conf Password & Password not matching.")
            return false
        }
        return true
    }
    //Configured with bitbucket repo

    
}

extension ChangePasswordVC {
    
    func updatePassword(block: @escaping (String?, Bool)-> Void){
        
        let pass = txtPass.text!
        let oldPass = txtOldPass.text!
        let confPass = txtConfPass.text!

        let pi = ProgressIndicator.show(message: "loading...")
        TheRoute.updatePassword(pass: pass, confPass: confPass, oldPass: oldPass).send(OnlyMsgResponse.self, then: { (results) in
            pi.close()
            switch results {
            case .failure(let error):
                print(error)
                block(error.localizedDescription, false)
                
                
            case .success(let data ):
                print(data)
                block(nil, true)
            }
    })
    }
        
}
