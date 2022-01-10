//
//  SignupDetailsViewController.swift
//  RoadStar Customer
//
//  Created by Roamer on 11/07/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class SignupDetailsViewController: BaseViewController {

    @IBOutlet weak var txtPass: SkyFloatingLabelTextField!
    @IBOutlet weak var txtAddressMain: SkyFloatingLabelTextField!
    @IBOutlet weak var txtEmail: SkyFloatingLabelTextField!
    @IBOutlet weak var txtSecondName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtFirstName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtAddress: SkyFloatingLabelTextField!
    
    var phoneNumber: String!
    
    override func setupUI() {
        txtAddress.text = phoneNumber
        
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    @IBAction func onCLickNextBtn(_ sender: Any) {
        
        callSignUpApi { (errorMsg, success) in
            
            if success == false && errorMsg != nil {
                Toast.showError(message: errorMsg!)
            }
            
            if success {
                
                self.callLoginApi { (errorMsg, success) in
                    
                    Toast.show(message: "Successfully registered!\nYou can logIn now.")
                    
                    if success == false && errorMsg != nil {
                        self.navigationController?.popToRootViewController(animated: true)
                        return
                    }
                    
                    if success {
                        
                        let vc = UIStoryboard.AppStoryboard.PreLogIn.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.PreLogin.UploadDocumentsViewController) as! UploadDocumentsViewController
                        vc.fromSignUP = true
                        self.navigationController?.pushViewController(vc, animated: true)
                        return
                            
                    }
                }
                //self.navigationController?.popToRootViewController(animated: true)
            }
        }
        
        return
        
        let homeNav = UIStoryboard.AppStoryboard.Main.instance.instantiateViewController(withIdentifier: UINavigationController.Identifiers.HomeNav) as! UINavigationController
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(homeNav, animated: true, completion: nil)
    }
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}
//Configured with bitbucket repo


extension SignupDetailsViewController {
    
    func callSignUpApi(_ block: @escaping (String?, Bool)-> Void){
    
        let pi = ProgressIndicator.show(message: "loading...")
        let user = SingupModel(password: txtPass.text!, email: txtEmail.text!, password_confirmation: txtPass.text!, first_name: txtFirstName.text!, last_name: txtSecondName.text!, home_address: txtAddressMain.text!, mobile: txtAddress.text!, login_by: "manual", comp_name: "", number_of_vehicle: "")
        
        TheRoute.signup(user: user).send(SingupModelResponse.self) { (results) in
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
    
    func callLoginApi(_ block: @escaping (String?, Bool)-> Void){
    
        let pi = ProgressIndicator.show(message: "loading...")
        let user = LoginModel(grantType: "password", clientID: 2, clientSecret: "WX2IZR5Yi6gpZ3ajSJ4meKik3R0K1z2vomJVc2Qw", email: txtEmail.text!, password: txtPass.text!, scope: "")
        
        TheRoute.login(user: user).send(LoginModelResponse.self) { (results) in
            pi.close()
            switch results {
            case .failure(let error):
                print(error)
                block(error.localizedDescription, false)
                
                
            case .success(let data ):
                print(data)
                UserSession.shared.user = data
                
                block(nil, true)
            }
        }
    }
}
