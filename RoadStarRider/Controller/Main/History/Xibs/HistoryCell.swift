//
//  HistoryCell.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/6/8.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import UIKit

class HistoryCell: UITableViewCell {

    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTotalEarning: UILabel!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var lblFrom: UILabel!
    
    
    func setUp(date: String, id: String, earning: String, to: String, from: String) {
        
        vwMain.layer.cornerRadius = 12
        
        lblID.text = id
        lblDate.text = date
        lblTotalEarning.text = "$\(earning)"
        lblTo.text = to
        lblFrom.text = from
    }
    
}
