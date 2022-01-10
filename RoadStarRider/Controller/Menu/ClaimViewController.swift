//
//  ClaimViewController.swift
//  RoadStar Customer
//
//  Created by Roamer on 21/07/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import UIKit

class ClaimViewController: BaseViewController {

    @IBOutlet weak var vwSubmitted: UIView!
    @IBOutlet weak var vwMain: UIView!
    
    override func setupUI() {
        
        vwMain.isHidden = false
        vwSubmitted.isHidden = true        
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    @IBAction func btnSubmitTapped(_ sender: Any) {
        
        vwMain.isHidden = true
        vwSubmitted.isHidden = false
    }
}
