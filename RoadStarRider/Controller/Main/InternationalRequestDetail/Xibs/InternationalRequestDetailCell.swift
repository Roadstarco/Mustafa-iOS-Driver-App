//
//  InternationalRequestDetailCell.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/6/26.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SDWebImage

class InternationalRequestDetailCell: UITableViewCell {

    @IBOutlet weak var theButton: PrimaryButton!
    @IBOutlet weak var txtItemName: SkyFloatingLabelTextField!
    @IBOutlet weak var txtDeliveryFrom: SkyFloatingLabelTextField!
    @IBOutlet weak var txtDeliveryTo: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtArrivalDate: SkyFloatingLabelTextField!
    @IBOutlet weak var txtItemSize: SkyFloatingLabelTextField!
    @IBOutlet weak var txtItemType: SkyFloatingLabelTextField!
    
    @IBOutlet weak var txtViewParcelDetail: PrimaryTextView!
    @IBOutlet var imgAttachments: [UIImageView]!
    @IBOutlet weak var btnViewCounterDetails: PrimaryButton!
    
    @IBOutlet weak var btnChat: PrimaryButton!
    @IBOutlet weak var imgPickedUp: UIImageView!
    @IBOutlet weak var imgDroppedOff: UIImageView!
    
    @IBOutlet weak var vwPickedUp: UIView!
    
    var request: InternationalRequest? = nil
    var theRequest: ScheduledTripResponse? = nil
    var parent: InternationalRequestDetailVC!
    var fromTripRequests = false
    var user_id = 0
    var first_name = ""
    var email = ""
    var picture = ""
    
    func setUp(request: InternationalRequest, parent: InternationalRequestDetailVC) {
        self.vwPickedUp.isHidden = true
        self.btnViewCounterDetails.isHidden = true
        self.btnChat.isHidden = true
        
        theButton.setTitle("ADD BID", for: .normal)
        if request.bid_details?.id != nil{
            print(request.bid_details?.id)
            theButton.setTitle("VIEW BID", for: .normal)
        }
        if request.bid_details?.is_counter == 1 && request.tripStatus == "PENDING" {
            
            self.btnViewCounterDetails.isHidden = false
            
        }
        self.request = request
        self.parent = parent
        let itemName = request.item ?? ""
        let deliveryFrom = request.tripfrom ?? ""
        let deliveryTo = request.tripto ?? ""
        let arrivalData = request.arrivalDate ?? ""
        let itemSize = request.itemSize ?? ""
        let itemType = request.itemType ?? ""
        let parcelDetail = request.otherInformation ?? ""
        
        txtItemName.text = itemName
        txtDeliveryFrom.text = deliveryFrom
        txtDeliveryTo.text = deliveryTo
        txtArrivalDate.text = arrivalData
        txtItemSize.text = itemSize
        txtItemType.text = itemType
        txtViewParcelDetail.text = parcelDetail
        
        let img1 = request.picture1
        let img2 = request.picture2
        let img3 = request.picture3
        
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
    
    func getButtonTitle() -> String {
        
        guard let req = self.theRequest else { return "START PROCESS" }
        
        if req.tripStatus == "SCHEDULED" {
            return "START PROCESS"
        } else if req.tripStatus == "STARTED" {
            return "TAP WHEN ARRIVED"
        } else if req.tripStatus == "ARRIVED" {
            return "PICKUP PACKAGE"
        } else if req.tripStatus == "PICKEDUP" {
            return "TAP WHEN DELIVERED"
        }
        return "START PROCESS"
    }
    
    func setUpTheRequest(request: ScheduledTripResponse, parent: InternationalRequestDetailVC) {
        if request.pickedupImage != ""{
            self.imgPickedUp.sd_setImage(with: URL(string: request.pickedupImage ?? ""))
        }else{
            self.imgPickedUp.image = UIImage(named: "placeholder_news")
        }
        if request.droppedofImage != ""{
            self.imgDroppedOff.sd_setImage(with: URL(string: request.droppedofImage ?? ""))
        }else{
            self.imgDroppedOff.image = UIImage(named: "placeholder_news")
        }

        self.user_id = request.userID ?? 0
        self.first_name = request.first_name ?? ""
        self.email = request.email ?? ""
        if request.picture != nil{
            self.picture = request.picture!
        }
        self.btnChat.isHidden = false
        self.btnViewCounterDetails.isHidden = true
        self.theRequest = request
        theButton.setTitle(getButtonTitle(), for: .normal)
        theButton.isHidden = request.tripStatus == "COMPLETED"
        
        self.parent = parent
        let itemName = request.item ?? ""
        let deliveryFrom = request.tripfrom ?? ""
        let deliveryTo = request.tripto ?? ""
        let arrivalData = request.arrivalDate ?? ""
        let itemSize = request.itemSize ?? ""
        let itemType = request.itemType ?? ""
        let parcelDetail = request.otherInformation ?? ""
        
        txtItemName.text = itemName
        txtDeliveryFrom.text = deliveryFrom
        txtDeliveryTo.text = deliveryTo
        txtArrivalDate.text = arrivalData
        txtItemSize.text = itemSize
        txtItemType.text = itemType
        txtViewParcelDetail.text = parcelDetail
        
        let img1 = request.picture1
        let img2 = request.picture2
        let img3 = request.picture3
        
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
    
    @IBAction func btnBidNowTapped(_ sender: UIButton) {

        
        if let req = request {
            if let id = req.id {
                let vc = InternationalSubmitRequestVC.instantiateMenu()
                print(String(id))
                if request?.bid_details?.amount != nil {
                    let bidAmount = (request?.bid_details?.amount)! as Int
                    let bidAmountString = String(bidAmount)
                    vc.bidAmount = bidAmountString
                    vc.bidMsg = (request?.bid_details?.traveller_response)!
                    vc.bidServiceType = (request?.bid_details?.service_type)!
                    
                }
                
                vc.setup(id: String(id)) {
                    self.parent.navigationController?.popToRootViewController(animated: true)
                }
                
                parent.present(vc, animated: true, completion: nil)
            }
        } else if let theReq = theRequest {
            print(theReq.serviceType as Any)
            print(theReq.tripStatus as Any)
            if theReq.tripStatus == "SCHEDULED" {
                print(theReq.serviceType as Any)
                if theReq.serviceType == "By Air" {
                    let vc = InternationalProcessStartVC.instantiateMenu()
                    vc.initialize(delegate: parent)
                    vc.modalPresentationStyle = .fullScreen
                    parent.present(vc, animated: true, completion: nil)
                }
                else if theReq.serviceType == "By Sea" {
                    let vc = BySeaProcessStartViewController.instantiateMenu()
                    vc.initialize(delegate: parent)
                    vc.modalPresentationStyle = .fullScreen
                    parent.present(vc, animated: true, completion: nil)
                }
                else {
                    if let status = parent.getStatus() {
                        parent.changeRequestStatus(status: status, airport: nil, flightNo: nil, ident: nil, vesselId: nil, sourcePortId: nil, destinationPortId: nil, imgKey: nil, img: nil, vesselName: nil, vesselimo: nil, fromAirplane: false) { (msg, success) in
                            
                            self.parent.theTableView.reloadData()
                        }
                    }
                    print(theReq.serviceType as Any)
                    
                    
                }
                
            }else if theReq.tripStatus == "STARTED" {
              if let status = parent.getStatus() {
                  parent.changeRequestStatus(status: status, airport: nil, flightNo: nil, ident: nil, vesselId: nil, sourcePortId: nil, destinationPortId: nil, imgKey: nil, img: nil, vesselName: nil, vesselimo: nil, fromAirplane: false) { (msg, success) in
                                        self.parent.theTableView.reloadData()
                                    }
                                }
                }else if theReq.tripStatus == "ARRIVED" {
//                if let status = parent.getStatus() {
                    self.parent.imagePicker.present(from: sender, showCamera: true, showLibrary: true)

//                    parent.changeRequestStatus(status: status, airport: nil, flightNo: nil, ident: nil, vesselId: nil, sourcePortId: nil, destinationPortId: nil, imgKey: nil, img: nil) { (msg, success) in
//                        
//                        self.parent.theTableView.reloadData()
//                    }
//                }
            } else if theReq.tripStatus == "PICKEDUP" {
                
                self.parent.imagePicker.present(from: sender, showCamera: true, showLibrary: true)
                self.parent.fromDelivered = true
            }
//            else if theReq.tripStatus == "DROPPED" {
//                self.parent.imagePicker.present(from: sender, showCamera: true, showLibrary: true)
//            }
            
        }
        
    }
    
    
    func continueToMain() {

        let homeNav = UIStoryboard.AppStoryboard.Main.instance.instantiateViewController(withIdentifier: UINavigationController.Identifiers.HomeNav) as! UINavigationController
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(homeNav, animated: true, completion: nil)
    }
    
    @IBAction func viewCounterDetailsTapped(_ sender: Any) {
        let vc = InternationalViewCounterVC.instantiateMenu()
        let counterAmount = (request?.bid_details?.counter_amount)! as Int
        let counterAmountString = String(counterAmount)
        vc.bidId = (request?.bid_details?.id)!
        vc.tripId = (request?.bid_details?.trip_id)!
        vc.counterAmount = counterAmountString
        let navigationCont = UINavigationController(rootViewController: vc)
        navigationCont.navigationController?.setNavigationBarHidden(true, animated: false)
        navigationCont.modalPresentationStyle = .overCurrentContext
        self.parent.present(navigationCont, animated: true, completion: nil)
    }
    
    
    @IBAction func btnChatTapped(_ sender: Any) {
        
        let vc = SupportViewController.instantiateMenu()
        vc.user_id = self.user_id
        vc.first_name = self.first_name
        vc.email = self.email
        vc.picture = self.picture
        let navigationCont = UINavigationController(rootViewController: vc)
        navigationCont.navigationController?.setNavigationBarHidden(true, animated: false)
        navigationCont.modalPresentationStyle = .overCurrentContext
        self.parent.present(navigationCont, animated: true, completion: nil)
        
        
    }
    
}

//ARRIVED
//PICKEDUP
//DROPPED
//COMPLETED
//RATE
