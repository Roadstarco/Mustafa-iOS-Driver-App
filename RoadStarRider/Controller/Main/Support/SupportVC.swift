//
//  SupportVC.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/6/7.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SDWebImage

class SupportVC: BaseViewController, Storyboarded {
    
    @IBOutlet weak var vwSubject: UIView!
    @IBOutlet weak var vwMessage: UIView!
    @IBOutlet weak var txtSubject: UITextField!
    @IBOutlet weak var txtViewMessage: UITextView!
    
    
    override func setupUI() {
        
        vwSubject.layer.cornerRadius = 8
        vwMessage.layer.cornerRadius = 8
    }
    
    @IBAction func btnSendTapped(_ sender: UIButton) {
        
        if isValidate() {
            self.sendRequest { (msg, success) in
                
                if success {
                    Toast.show(message: "Support Email Sent successfully. Our team will contact you soon!")
                    
                    var redirect : RedirectHelper!
                    redirect = RedirectHelper(window: nil)
                    redirect.determineRoutes()
                }
            }
        }
    }

    func isValidate() -> Bool {
        
        if txtSubject.text == nil {
            Toast.showError(message: "Enter Subject")
            return false
        } else if txtSubject.text!.isEmpty {
            Toast.showError(message: "Enter Subject")
            return false
        } else if txtViewMessage.text == nil {
            Toast.showError(message: "Enter Message")
            return false
        } else if txtViewMessage.text!.isEmpty {
            Toast.showError(message: "Enter Message")
            return false
        }
        
        return true
        
    }
}


extension SupportVC {
    
    func sendRequest(block: @escaping (String?, Bool)-> Void){

        let pi = ProgressIndicator.show(message: "loading...")
        
        TheRoute.sendSupport(subject: txtSubject.text!, message: txtViewMessage.text!).send(OnlyMsgResponse.self, data: nil, multipleData: nil) { (progress) in
            print(progress)
        } then: { (results) in
            pi.close()
            switch results {
            case .failure(let error):
                print(error)
                block(error.localizedDescription, false)
                
                
            case .success(let data ):
                print(data)
                block(nil, true)
            }
        }
    }
}

