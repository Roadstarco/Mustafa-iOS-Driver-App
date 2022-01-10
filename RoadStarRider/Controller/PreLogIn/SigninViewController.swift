//
//  SigninViewController.swift
//  RoadStar Customer
//
//  Created by Roamer on 11/07/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField

class SigninViewController: BaseViewController {

    @IBOutlet weak var txtPass: SkyFloatingLabelTextField!
    @IBOutlet weak var txtEmail: SkyFloatingLabelTextField!
    
    override func setupUI() {
        
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    //Configured with bitbucket repo

    @IBAction func onCLickNextBtn(_ sender: Any) {
        
        if txtEmail.text == nil {
            Toast.showError(message: "Email field is empty")
            return
        } else if txtEmail.text!.isEmpty {
            Toast.showError(message: "Email field is empty")
            return
        } else if txtPass.text == nil {
            Toast.showError(message: "Password field is empty")
            return
        } else if txtPass.text!.isEmpty {
            Toast.showError(message: "Password field is empty")
            return
        } else if txtPass.text!.count < 6 {
            Toast.showError(message: "Password should be atleast 6 char")
            return
        }
        
        callLoginApi { (errorMsg, success) in
            
            if success == false && errorMsg != nil {
                Toast.showError(message: errorMsg!)
            }
            
            if success {
                
                let homeNav = UIStoryboard.AppStoryboard.Main.instance.instantiateViewController(withIdentifier: UINavigationController.Identifiers.HomeNav) as! UINavigationController
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(homeNav, animated: true, completion: nil)
            }
        }
        
    }
    
    @IBAction func onCLickSignUp(_ sender: Any) {
        
        
        let signUpVc = UIStoryboard.AppStoryboard.PreLogIn.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.PreLogin.SignUpTypeVC) as! SignUpTypeVC
        self.navigationController?.pushViewController(signUpVc, animated: true)
    }
    
    @IBAction func onCLickForgotPassBtn(_ sender: Any) {
        let forgotPassVC = UIStoryboard.AppStoryboard.PreLogIn.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.PreLogin.ForgetPasswordViewController) as! ForgetPasswordViewController
        self.navigationController?.pushViewController(forgotPassVC, animated: true)
    }
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}


extension SigninViewController {
    
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
