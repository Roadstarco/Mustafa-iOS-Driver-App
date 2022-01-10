//
//  RequestDetailCell.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/6/14.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SDWebImage

class RequestDetailCell: UITableViewCell {

    @IBOutlet weak var txtCategory: SkyFloatingLabelTextField!
    @IBOutlet weak var txtProductType: SkyFloatingLabelTextField!
    @IBOutlet weak var txtProductWeight: SkyFloatingLabelTextField!
    @IBOutlet weak var txtHeight: SkyFloatingLabelTextField!
    @IBOutlet weak var txtWidth: SkyFloatingLabelTextField!
    
    @IBOutlet var imgAttachments: [UIImageView]!
    @IBOutlet weak var txtViewProductDistribution: PrimaryTextView!
    @IBOutlet weak var txtViewInstructions: PrimaryTextView!
    @IBOutlet weak var txtReceiver: SkyFloatingLabelTextField!
    @IBOutlet weak var txtReceiverNumber: SkyFloatingLabelTextField!
    @IBOutlet weak var lblFrom: UILabel!
    @IBOutlet weak var lblTo: UILabel!
    
    
    var request: TripRequestData!
    var parent: RequestDetailVC!
    
    func setUp(request: TripRequestData, parent: RequestDetailVC) {

        self.request = request
        self.parent = parent
        let category = request.request?.category ?? "N/A"
        let productType = request.request?.productType ?? "N/A"
        let productWeight = request.request?.productWeight ?? "N/A"
        let height = request.request?.productHeight ?? "N/A"
        let width = request.request?.productWidth ?? "N/A"
        let distribution = request.request?.productDistribution ?? "N/A"
        let instruction = request.request?.instruction ?? "N/A"
        let receiverName = request.request?.receiverName ?? "N/A"
        let receiverNumber = request.request?.receiverPhone ?? "N/A"
        let from = request.request?.sAddress ?? "N/A"
        let to = request.request?.dAddress ?? "N/A"
        
        let img1 = request.request?.attachment1
        let img2 = request.request?.attachment2
        let img3 = request.request?.attachment3
        
        txtCategory.text = category
        txtProductType.text = productType
        txtProductWeight.text = productWeight
        txtHeight.text = height
        txtWidth.text = width
        txtViewProductDistribution.text = distribution
        txtViewInstructions.text = instruction
        txtReceiver.text = receiverName
        txtReceiverNumber.text = receiverNumber
        lblFrom.text = from
        lblTo.text = to
        
        if let img = img1 {
            if let url = URL(string: img) {
                imgAttachments[0].sd_imageIndicator = SDWebImageActivityIndicator.gray
                imgAttachments[0].sd_setImage(with: url, placeholderImage: UIImage(named: "manPHIcon"))
            }
        }
        
        if let img = img2 {
            if let url = URL(string: img) {
                imgAttachments[1].sd_imageIndicator = SDWebImageActivityIndicator.gray
                imgAttachments[1].sd_setImage(with: url, placeholderImage: UIImage(named: "manPHIcon"))
            }
        }
        
        if let img = img3 {
            if let url = URL(string: img) {
                imgAttachments[2].sd_imageIndicator = SDWebImageActivityIndicator.gray
                imgAttachments[2].sd_setImage(with: url, placeholderImage: UIImage(named: "manPHIcon"))
            }
        }
        
    }
    
    @IBAction func btnAccept(_ sender: Any) {
        
        guard let theReq = parent.localRequest.request else {return}
        
        if theReq.providerRated == 0 && theReq.status == "COMPLETED" {
            let vc = UIStoryboard.AppStoryboard.Menu.instance.instantiateViewController(withIdentifier: "RequestMapDetailVC") as! RequestMapDetailVC
            vc.initialize(localRequest: theReq)
            self.parent.navigationController?.pushViewController(vc, animated: true)
            return
        }
        
        parent.acceptRequest { (msg, success) in
            
            if success {
                if let req = self.parent.theRequest {
                    let vc = UIStoryboard.AppStoryboard.Menu.instance.instantiateViewController(withIdentifier: "RequestMapDetailVC") as! RequestMapDetailVC
                    vc.initialize(localRequest: req)
                    self.parent.navigationController?.pushViewController(vc, animated: true)
                    
                }
                
            }
        }
        
        
        
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        
        
    }
}
