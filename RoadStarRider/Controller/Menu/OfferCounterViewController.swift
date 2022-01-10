//
//  OfferCounterViewController.swift
//  RoadStarRider
//
//  Created by Apple on 15/12/2021.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import Foundation
import UIKit
import Alamofire
import SkyFloatingLabelTextField
class OfferCounterViewController: BaseViewController, Storyboarded{
    
    @IBOutlet weak var amountTxt: SkyFloatingLabelTextField!
    @IBOutlet weak var btnAddBid: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    
    var bid_id = 0
    
    override func setupUI() {
        
        
        
    }
    
    @IBAction func btnAddBidTapped(_ sender: Any) {
        if isValidate() {
            
        self.acceptBid()
            
        }
    }
    
    func acceptBid(){
        
        let pi = ProgressIndicator.show(message: "loading...")
        TheRoute.offerCounter(bid_id: self.bid_id, counter_amount: amountTxt.text!).send(AcceptBidResponse.self, data: nil, multipleData: nil) { (progress) in
            print(progress)
        } then: { (results) in
            pi.close()
            switch results {
            case .failure(let error):
                print(error)
                Toast.showError(message: "Something Went Wrong!")
                
                
                
            case .success(let data ):
                print(data)
                Toast.show(message: "Counter Offer Sent Successfully")
                self.continueToMain()
                
                
                
            }
        }
    }
    
    func continueToMain() {

        let homeNav = UIStoryboard.AppStoryboard.Main.instance.instantiateViewController(withIdentifier: UINavigationController.Identifiers.HomeNav) as! UINavigationController
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(homeNav, animated: true, completion: nil)

    }
    
    func isValidate() -> Bool {
        
        if amountTxt.text == nil {
            Toast.showError(message: "Please enter counter amount")
            return false
        } else if amountTxt.text!.isEmpty {
            Toast.showError(message: "Please enter counter amount")
            return false
        }
        
        return true
    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        self.dismiss(animated: true)

    }
    
    
}
