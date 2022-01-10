//
//  RatingViewController.swift
//  RoadStar Customer
//
//  Created by Roamer on 21/07/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import UIKit

class RatingViewController: BaseViewController {

    override func setupUI() {
        
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }

    @IBAction func btnRateStarTapped(_ sender: Any) {
        self.navigationController?.dismiss(animated: true, completion: nil)
//        self.dismiss(animated: true, completion: nil)
    }
}
