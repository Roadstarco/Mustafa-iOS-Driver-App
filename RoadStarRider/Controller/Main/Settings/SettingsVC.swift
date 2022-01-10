//
//  SettingsVC.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/5/30.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import UIKit

class SettingsVC: BaseViewController, Storyboarded {
    
    override func setupUI() {
        
    }
    
    @IBAction func btnSwitch(_ sender: Any) {
        
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnChangePassTapped(_ sender: Any) {
        
        let vc = ChangePasswordVC.instantiatePreLogin()
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
