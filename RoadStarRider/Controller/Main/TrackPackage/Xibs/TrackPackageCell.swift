//
//  TrackPackageCell.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/7/3.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import UIKit

class TrackPackageCell: UITableViewCell {

    @IBOutlet weak var lblID: UILabel!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblTotalEarning: UILabel!
    @IBOutlet weak var lblTo: UILabel!
    @IBOutlet weak var lblFrom: UILabel!
    
    
    func setUp(request: ScheduledTripResponse, parent: UIViewController) {
        
        vwMain.layer.cornerRadius = 12
        
        let date = request.createdAt ?? ""
        let id = request.bookingID ?? ""
        let status = request.tripStatus ?? ""
        let to = request.tripto ?? ""
        let from = request.tripfrom ?? ""
        
        lblID.text = id
        lblDate.text = date
        lblTotalEarning.text = status
        lblTo.text = to
        lblFrom.text = from
    }
    
}
