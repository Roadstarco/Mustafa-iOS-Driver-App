//
//  TripRequestsCell.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/6/14.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import UIKit

class TripRequestsCell: UITableViewCell {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var vwBottom: UIView!
    
    var request: TripRequestData!
    var parent: UIViewController!
    
    func setUp(request: TripRequestData, parent: UIViewController) {
        
        self.request = request
        self.parent = parent
        vwMain.layer.cornerRadius = 12
        vwBottom.roundCorners(with: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner], radius: 12)
        
        let name = request.request?.user?.firstName ?? "N/A"
        let address = request.request?.sAddress ?? "N/A"
        let time = request.request?.assignedAt ?? "N/A"
        
        lblName.text = name
        lblAddress.text = address
        lblTime.text = time
    }
    
    @IBAction func btnDetailTapped(_ sender: Any) {
        
        let vc = UIStoryboard.AppStoryboard.Menu.instance.instantiateViewController(withIdentifier: "RequestDetailVC") as! RequestDetailVC
        vc.initialize(localRequest: request)
        self.parent.navigationController?.pushViewController(vc, animated: true)
        
    }
}
