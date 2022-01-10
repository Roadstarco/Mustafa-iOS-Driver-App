//
//  EarningCell.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/6/7.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import UIKit

class EarningCell: UITableViewCell {

    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTotalEarning: UILabel!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var lblFrom: UILabel!
    
    
    func setUp(history: EarningHistoryInternationalJob) {
        
        vwMain.layer.cornerRadius = 12
        
        let date = history.createdAt ?? ""
        let id = history.bookingID ?? ""
        let earning = history.tripAmount ?? 0
        let to = history.tripto ?? ""
        let from = history.tripfrom ?? ""
        
        lblID.text = id
        lblDate.text = date
        lblTotalEarning.text = "$\(earning)"
        lblTo.text = to
        lblFrom.text = from
    }
    
    func setUpLocal(history: LocalJob) {
        
        vwMain.layer.cornerRadius = 12
        
        let date = history.startedAt ?? ""
        let id = history.bookingID ?? ""
        let earning = history.payment?.total ?? 0
        let to = history.dAddress ?? ""
        let from = history.sAddress ?? ""
        
        lblID.text = id
        lblDate.text = date
        lblTotalEarning.text = "$\(earning)"
        lblTo.text = to
        lblFrom.text = from
    }

    
}
