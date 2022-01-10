//
//  InternationalProcessStartCell.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/7/3.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import UIKit

class InternationalProcessStartCell: UITableViewCell {

    @IBOutlet weak var lblTitle: UILabel!
    
    func setup(name: String) {
        
        lblTitle.text = name
    }
    //Configured with bitbucket repo

}
