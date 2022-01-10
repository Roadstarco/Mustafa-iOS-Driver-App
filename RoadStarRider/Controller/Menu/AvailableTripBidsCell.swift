//
//  AvailableTripBidsCell.swift
//  RoadStarRider
//
//  Created by Apple on 14/12/2021.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import Foundation
import UIKit

class AvailableTripBidsCell: UITableViewCell{
    
    
    @IBOutlet weak var lblCreatedAt: UILabel!
    @IBOutlet weak var lblProviderId: UILabel!
    
    @IBOutlet weak var lblBidAmount: UILabel!
    @IBOutlet weak var lblFirstName: UILabel!
    
    @IBOutlet weak var lblSecondName: UILabel!
    @IBOutlet weak var btnAccept: PrimaryButton!
    
    @IBOutlet weak var btnAddCounter: PrimaryButton!
    @IBOutlet weak var btnViewStatus: PrimaryButton!
    
    @IBOutlet weak var vwMain: RoundShadowView!
    @IBOutlet weak var lblCounterSent: UILabel!
    
    var trip_id = 0
    var bid_id = 0
    
    var parent: UIViewController!
    var internationalRequests: ScheduledTripResponse?

    static let nibName: String              = "AvailableTripBidsCell"
    static let cellReuseIdentifier: String  = "AvailableTripBidsCell"
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        lblCounterSent.isHidden = true
        vwMain.containerView.backgroundColor = Theme.backgroundColor
        // Initialization code
    }
    
    func setUp(result: AvailableTripBidsResponse, parent: UIViewController){
        self.trip_id = result.trip_id!
        self.bid_id = result.id!
        self.parent = parent
        if result.provider_id != nil{
            let providerId = (result.provider_id ?? 0) as Int
            let providerIdString = String(providerId)
            lblProviderId.text = providerIdString

        }
            lblCreatedAt.text = result.created_at
            let bidAmount = (result.amount ?? 0) as Int
            let bidAmountString = String(bidAmount)
            lblFirstName.text = ("First Name: \(result.first_name ?? "Name")")
            lblSecondName.text = ("Last Name: \(result.last_name ?? "Name")")
            lblBidAmount.text = ("$\(bidAmountString)")
            btnAddCounter.setTitleColor(.red, for: .normal)
            btnAddCounter.backgroundColor = .white
            btnAddCounter.layer.borderWidth = 2
            btnAddCounter.layer.borderColor = UIColor.red.cgColor

        if result.status == "Pending"{
            btnViewStatus.isHidden = true
            btnAddCounter.isHidden = false
            btnAccept.isHidden = false
            
        }else{
            btnViewStatus.isHidden = false
            btnAddCounter.isHidden = true
            btnAccept.isHidden = true
            lblCounterSent.isHidden = true
        }
        
        if result.is_counter == 1 && result.status == "Pending"{
            
            lblCounterSent.isHidden = false
            lblCounterSent.text = ("Your counter offer of \(result.counter_amount ?? 0) has been sent successfully and waiting for approval")
            btnAccept.isHidden = true
            btnAddCounter.isHidden = true
            
        }
        
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    @IBAction func btnAcceptTapped(_ sender: Any) {
        
        self.acceptBid()
        
        
    }
    
    func acceptBid(){
        let travellerResponse = "Thanks for offering my a bid. I`m glad to accept you offer" as String
        let pi = ProgressIndicator.show(message: "loading...")
        TheRoute.acceptBid(bid_id: self.bid_id,
                           trip_id: self.trip_id,
                           traveller_response: travellerResponse,
                           status: "Approved").send(AcceptBidResponse.self, data: nil, multipleData: nil) { (progress) in
            print(progress)
        } then: { (results) in
            pi.close()
            switch results {
            case .failure(let error):
                print(error)
                Toast.showError(message: "Something Went Wrong!")
                
                
                
            case .success(let data ):
                print(data)
                Toast.show(message: "Bid Accepted Successfully")
                self.continueToMain()
                
                
                
            }
        }
    }
    
    func continueToMain() {

        let homeNav = UIStoryboard.AppStoryboard.Main.instance.instantiateViewController(withIdentifier: UINavigationController.Identifiers.HomeNav) as! UINavigationController
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(homeNav, animated: true, completion: nil)

    }
    
    @IBAction func btnAddCounterTapped(_ sender: Any) {
        
        let vc = UIStoryboard.AppStoryboard.Menu.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.Menu.OfferCounterViewController) as! OfferCounterViewController
        vc.bid_id = self.bid_id
        
        let navigationCont = UINavigationController(rootViewController: vc)
        navigationCont.navigationController?.setNavigationBarHidden(true, animated: false)
        navigationCont.modalPresentationStyle = .overCurrentContext
        self.parent.present(navigationCont, animated: true, completion: nil)
        
    }
    
    @IBAction func btnViewStatusTapped(_ sender: Any) {
        let vc = InternationalRequestDetailVC.instantiateMenu()
        vc.initialize(request: nil, theRequest: internationalRequests)
        vc.reqId = self.internationalRequests?.id
        vc.modalPresentationStyle = .fullScreen
        self.parent?.present(vc, animated: true)
    }
}
