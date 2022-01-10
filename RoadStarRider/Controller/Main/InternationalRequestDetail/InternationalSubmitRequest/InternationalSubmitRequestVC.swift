//
//  InternationalSubmitRequestVC.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/6/28.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import iOSDropDown

class InternationalSubmitRequestVC: UIViewController, Storyboarded {

    @IBOutlet weak var txtMessage: SkyFloatingLabelTextField!
    @IBOutlet weak var txtAmount: SkyFloatingLabelTextField!
    @IBOutlet weak var theDropDown: DropDown!
    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var btnAddBid: UIButton!
    
    var tripId: String!
    var type: String? = nil
    var block: (()-> Void?)? = nil
    var bidAmount: String = ""
    var bidMsg: String = ""
    var bidServiceType: String = ""
    var counterAmount: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if (self.bidAmount != "") || (self.bidServiceType != "") {
            self.txtMessage.isUserInteractionEnabled = false
            self.txtAmount.isUserInteractionEnabled = false
            self.theDropDown.isUserInteractionEnabled = false
            self.btnAddBid.isHidden = true
            self.txtAmount.text = self.bidAmount
            self.txtMessage.text = self.bidMsg
            self.theDropDown.text = self.bidServiceType
            
        }
        
        theDropDown.optionArray = ["Service Type", "By Road", "By Sea", "By Air"]
        theDropDown.optionIds = [1,2,3,4]
        
        theDropDown.didSelect{(selectedText , index ,id) in
            self.type = selectedText
            
        }
    }
    
    func setup(id: String, block: @escaping ()-> Void) {
        self.tripId = id
        self.block = block
    }

    @IBAction func btnAddBidTapped(_ sender: Any) {
        if txtAmount.text == nil {
            Toast.showError(message: "Amount required.")
            return
        } else if txtAmount.text!.isEmpty {
            Toast.showError(message: "Amount required.")
            return
        } else if type == nil {
            Toast.showError(message: "Type required.")
            return
        }
        
        self.sendBid { (msg, success) in
            
            if success {
                self.dismiss(animated: true) {
                    self.block?()
                }
            }
        }
    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    func sendBid(block: @escaping (String?, Bool)-> Void){
        
        let pi = ProgressIndicator.show(message: "loading...")
        TheRoute.bidUser(tripId: self.tripId, serviceType: self.type!, travellerResponse: txtMessage.text ?? "", amount: txtAmount.text!).send(BidUserResponse.self, data: nil, multipleData: nil) { (progress) in
            print(progress)
        } then: { (results) in
            pi.close()
            switch results {
            case .failure(let error):
                print(error)
                block(error.localizedDescription, false)
                
                
            case .success(let data ):
                print(data)
                
                block(nil, true)
                
            }
        }
    }
    

    
}
