//
//  SignUpTypeVC.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2020/9/9.
//  Copyright © 2020 Faizan Ali . All rights reserved.
//

import UIKit

class SignUpTypeVC: BaseViewController {

    
    override func setupUI() {
        
    }
    
    override func setupTheme() {
        super.setupTheme()
    }
    
    @IBAction func btnCompanyTapped(_ sender: Any) {
        
        AppURL.registerAsCompany.open(parent: self)
    }
    //Configured with bitbucket repo

    @IBAction func btnDriverTapped(_ sender: Any) {
        
        let signUpVc = UIStoryboard.AppStoryboard.PreLogIn.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.PreLogin.SignUpViewController) as! SignUpViewController
        self.navigationController?.pushViewController(signUpVc, animated: true)
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
