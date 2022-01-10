//
//  WelcomeViewController.swift
//  RoadStar Customer
//
//  Created by Roamer on 11/07/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import UIKit

class WelcomeViewController: BaseViewController {

    
    override func setupUI() {
        
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    

    
    @IBAction func onClickSignIn(_ sender: UIButton) {
        let signInVC = UIStoryboard.AppStoryboard.PreLogIn.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.PreLogin.SignInViewController) as! SigninViewController
        self.navigationController?.pushViewController(signInVC, animated: true)
    }
    
    @IBAction func onCLickSignUp(_ sender: UIButton) {
        
        let signUpVc = UIStoryboard.AppStoryboard.PreLogIn.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.PreLogin.SignUpTypeVC) as! SignUpTypeVC
        self.navigationController?.pushViewController(signUpVc, animated: true)
    }
}
//Configured with bitbucket repo
