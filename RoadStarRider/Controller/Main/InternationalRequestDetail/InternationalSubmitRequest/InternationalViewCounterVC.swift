//
//  InternationalViewCounterVC.swift
//  RoadStarRider
//
//  Created by Apple on 01/12/2021.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import Foundation
import UIKit
import SkyFloatingLabelTextField
class InternationalViewCounterVC: UIViewController, Storyboarded {
    
    @IBOutlet weak var amountTextField: SkyFloatingLabelTextField!
    @IBOutlet weak var btnAccpet: UIButton!
    @IBOutlet weak var btnReject: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    var counterAmount: String = ""
    var tripId: Int = 0
    var bidId: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.amountTextField.isUserInteractionEnabled = false
        self.amountTextField.text = counterAmount
        
    }
    @IBAction func acceptTapped(_ sender: Any) {
        let pi = ProgressIndicator.show(message: "loading...")
        TheRoute.acceptCounter(trip_id: tripId, bid_id: bidId).send(OnlyMsgResponse.self, data: nil, multipleData: nil) { (progress) in
            print(progress)
        } then: { (results) in
            pi.close()
            switch results {
            case .failure(let error):
                print(error)
                Toast.show(message: "Something Went Wrong Please Try Again")
                
            case .success(let data ):
                print(data)
                Toast.show(message: "Counter Bid Accepted")
                let homeNav = UIStoryboard.AppStoryboard.Main.instance.instantiateViewController(withIdentifier: UINavigationController.Identifiers.HomeNav) as! UINavigationController
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(homeNav, animated: true, completion: nil)
                
            }
        }
        
    }
    
    @IBAction func rejectTapped(_ sender: Any) {
        let pi = ProgressIndicator.show(message: "loading...")
        TheRoute.rejectCounter(trip_id: tripId, bid_id: bidId).send(OnlyMsgResponse.self, data: nil, multipleData: nil) { (progress) in
            print(progress)
        } then: { (results) in
            pi.close()
            switch results {
            case .failure(let error):
                print(error)
                Toast.show(message: "Something Went Wrong Please Try Again")
                
                
            case .success(let data ):
                print(data)
                Toast.show(message: "Counter Bid Rejected")
                let homeNav = UIStoryboard.AppStoryboard.Main.instance.instantiateViewController(withIdentifier: UINavigationController.Identifiers.HomeNav) as! UINavigationController
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(homeNav, animated: true, completion: nil)
                
            }
        }
        
    }
    
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        self.dismiss(animated: true)
        
    }
    
}
