//
//  InternationalRequestDetailVC.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/6/26.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SDWebImage
import Cosmos

class InternationalRequestDetailVC: BaseViewController, Storyboarded {
    
    @IBOutlet weak var theTableView: UITableView!
    @IBOutlet weak var vwPayment: UIView!
    @IBOutlet weak var lblDeducted: UILabel!
    @IBOutlet weak var lblTotal: UILabel!
    @IBOutlet weak var lblBaseFare: UILabel!
    @IBOutlet weak var lblInvoiceNo: UILabel!
    @IBOutlet weak var ratingView: CosmosView!
    @IBOutlet weak var vwRating: UIView!
    @IBOutlet weak var txtViewComments: PrimaryTextView!
    
    var showPaymentView: Bool = false
    var rated: Bool = false
    var request: InternationalRequest? = nil
    var theRequest: ScheduledTripResponse? = nil
    var imagePicker: ImagePicker!
    var fromTripRequests = false
    var fromDelivered = false
    var currrentTripStatus: GetCurrentStatusResponse?
    var fromAirplane = false
    var fromPayment = false
    var reqId: Int?
    var pickedUpImage = ""
    var doppedOffImage = ""
    func initialize(request: InternationalRequest?, theRequest: ScheduledTripResponse?) {
        
        self.request = request
        self.theRequest = theRequest
//        if self.theRequest != nil{
//
//            self.getCurrentStatus()
//
//        }
    }
    
    override func setupUI() {
        print(self.reqId ?? 0)
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        registerXibs()
        checkSetup()
    }
    
    func registerXibs() {
        
        let nib = UINib.init(nibName: "InternationalRequestDetailCell", bundle: nil)
        theTableView.register(nib, forCellReuseIdentifier: "InternationalRequestDetailCell")
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.dismiss(animated: true)
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnConfirmTapped(_ sender: Any) {
        print(theRequest?.tripStatus as Any)
        if theRequest?.tripStatus == "DROPPED" {
          if let status = getStatus() {
              self.fromPayment = true
              self.changeRequestStatus(status: status, airport: nil, flightNo: nil, ident: nil, vesselId: nil, sourcePortId: nil, destinationPortId: nil, imgKey: nil, img: nil, vesselName: nil,  vesselimo: nil ,fromAirplane: false, block: { (msg, success) in
            
            })
          }
        }
     }
    
    func checkSetup() {
        
        self.vwRating.isHidden = true
        self.vwPayment.isHidden = true
        guard let req = self.theRequest else { return }
        
        
        
        if theRequest?.tripStatus == "DROPPED" {
            guard let req = self.theRequest else { return }
            print(req.payment as Any)
             let payment = req.payment
            
            self.vwPayment.isHidden = false
            let amount = (req.tripAmount ?? 0) as Int
            let amountString = String(amount)
            self.lblInvoiceNo.text = "Invoice" //\(payment?.id ?? 0)"
            self.lblBaseFare.text = amountString//"Invoice: \(payment?.fixed ?? 0)"
            self.lblTotal.text = amountString//"Invoice: \(payment?.total ?? 0)"
            self.lblDeducted.text = amountString//"Invoice: \(payment?.total ?? 0)"
            
            return
        }
        
        if rated { return }
        
        if req.providerRated == 0 && req.tripStatus == "COMPLETED" {
            self.vwRating.isHidden = false
            
        }
        
        if self.showPaymentView{
            self.vwRating.isHidden = false

            
        }
        
    }
    
    func getCurrentStatus(){
        
        let pi = ProgressIndicator.show(message: "loading...")
        TheRoute.getTripDetails(trip_id: (self.theRequest?.id)!,
                                uid: (self.theRequest?.providerID)!).send(GetCurrentStatusResponse.self, data: nil, multipleData: nil) { (progress) in
            print(progress)
        } then: { (results) in
            pi.close()
            switch results {
            case .failure(let error):
                print(error)
                
                
                
            case .success(let data ):
                print(data)
                self.currrentTripStatus = data
                self.checkSetup()
                
                
            }
        }
    }

    
    @IBAction func btnSubmitRatingTapped(_ sender: Any) {
        
        sendRating { (msg, success) in
            
            if success {
                self.rated = true
                self.checkSetup()
                self.continueToMain()
//                self.navigationController?.popViewController(animated: true)
            } else if let msg = msg {
                Toast.showError(message: "\(msg)")
            }
        }
    }
    
    func continueToMain() {

        let homeNav = UIStoryboard.AppStoryboard.Main.instance.instantiateViewController(withIdentifier: UINavigationController.Identifiers.HomeNav) as! UINavigationController
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(homeNav, animated: true, completion: nil)
    }
    
    func sendRating(block: @escaping (String?, Bool)-> Void){
        
        guard let req = self.theRequest else { return }
        
        let rating = self.ratingView.rating
        let note = self.txtViewComments.text ?? ""
        guard let reqId = self.reqId else {
            return
        }

        let pi = ProgressIndicator.show(message: "loading...")
        TheRoute.rateTripUser(tripId: String(reqId), rating: String(rating), comment: note).send(NormalSimpleResponse.self, data: nil, multipleData: nil) { (progress) in
            print(progress)
        } then: { (results) in
            pi.close()
            switch results {
            case .failure(let error):
                print(error)
                block(error.localizedDescription, false)
                
                
            case .success( _ ):
                block(nil, true)
            }
        }
    }

    
}


extension InternationalRequestDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InternationalRequestDetailCell") as! InternationalRequestDetailCell
        
        if let req = self.request {
            cell.fromTripRequests = self.fromTripRequests
            print(self.fromTripRequests)
            cell.setUp(request: req, parent: self)
            
        } else if let theReq = self.theRequest {
            cell.setUpTheRequest(request: theReq, parent: self)
        }
        
        return cell
    }
    
    
    
    
    
}


extension InternationalRequestDetailVC: InternationalRequestDetailProtocol {

    
    func getDataSea(ship: ShipResponse, fromShip: Bool) {
        if let status = getStatus() {
            print(status)
            changeRequestStatus(status: status, airport: nil, flightNo: nil, ident: nil, vesselId: ship.marine_traffic_id, sourcePortId: nil, destinationPortId: nil, imgKey: nil, img: nil, vesselName: ship.name, vesselimo: ship.imo, fromAirplane: fromShip) { (msg, success) in
                
                
            }
        }
    }
    
    
    func getData(airport: AirpoartResponse, flight: String, fromAirplane: Bool) {
        
        if let status = getStatus() {
            print(status)
            changeRequestStatus(status: status, airport: airport.iata_code, flightNo: flight, ident: airport.ident, vesselId: nil, sourcePortId: nil, destinationPortId: nil, imgKey: nil, img: nil,vesselName: nil,  vesselimo: nil, fromAirplane: fromAirplane) { (msg, success) in
                
                
            }
        }
    }
    
    func setupTheUI() {
        
        
    }
    
    
}


extension InternationalRequestDetailVC {
    
    func changeRequestStatus(status: String, airport: String?, flightNo: String?, ident: String?, vesselId: Int?, sourcePortId: String?, destinationPortId: String?, imgKey: String?, img: UIImage?, vesselName: String?, vesselimo: Int?, fromAirplane: Bool?, block: @escaping (String?, Bool)-> Void){
        
        guard let req = self.theRequest else { return }
        guard let reqId = self.reqId else { return }
        self.fromAirplane = fromAirplane!
        var data: UploadData? = nil
        if let img = img {
            if let key = imgKey {
                data = UploadData(data: img.pngData()!, fileName: "\(Date().timeIntervalSince1970).png", mimeType: "png", name: key)
            }
        }
        
        let pi = ProgressIndicator.show(message: "loading...")
        print(flightNo as Any)
        print(airport as Any)
        print(ident as Any)
        print(reqId as Any)
        print(status as Any)
        print(vesselId as Any)
        print(vesselName as Any)
        print(vesselimo as Any)
        TheRoute.acceptInternationalRequest(reqId: String(reqId), method: "PATCH", status: status, airport: airport, flightNo: flightNo, ident: ident, vesselId: vesselId, sourcePortId: sourcePortId, destinationPortId: destinationPortId, vessel_name: vesselName,  vessel_imo: vesselimo).send(ScheduledTripResponse.self, data: data, multipleData: nil) { (progress) in
            print(progress)
        } then: { (results) in
            pi.close()
            switch results {
            case .failure(let error):
                print(error)
                block(error.localizedDescription, false)
                
                
            case .success(let data ):
                print(data)
                if self.fromAirplane{
                if data.error == nil{
                    self.theRequest = data
                    self.theTableView.reloadData()
                    self.continueToTrack()
                } else {
                    
                    Toast.showError(message: self.theRequest?.error ?? "")
                }
                    
                    self.fromAirplane = false
                    
                } else if self.fromPayment {
                    
                    self.theRequest = data
                    self.showPaymentView = true
                    self.checkSetup()
                    self.fromPayment = false
                } else {
                    
                    self.theRequest = data
                    self.theTableView.reloadData()
                    self.checkSetup()
                    self.continueToTrack()
                }
                block(nil, true)
            }
        }
    }
    
    
    func getStatus() -> String? {
        
        guard let req = self.theRequest else { return nil }
        
        if req.tripStatus == "SCHEDULED" {
            return "STARTED"
        } else if req.tripStatus == "STARTED" {
            return "ARRIVED"
        } else if req.tripStatus == "ARRIVED" {
            return "PICKEDUP"
        } else if req.tripStatus == "PICKEDUP" {
            return "DROPPED"
        }else if req.tripStatus == "DROPPED" {
            return "COMPLETED"
        }
        return nil
    }
    
    func getImgKey() -> String? {
        
        guard let req = self.theRequest else { return nil }
        
        if req.tripStatus == "SCHEDULED" {
            return nil
        } else if req.tripStatus == "ARRIVED" {
            return "pickedUpImage"
        } else if req.tripStatus == "PICKEDUP" {
            return "droppedOfImage"
        } else if req.tripStatus == "DROPPED" {
            return "droppedOfImage"
        }
        return nil
    }
    
    func continueToTrack(){
        
        let vc = UIStoryboard.AppStoryboard.Menu.instance.instantiateViewController(withIdentifier: "ScheduledNav") as! UINavigationController
        
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(vc, animated: true, completion: nil)
        
        
    }
    
}



extension InternationalRequestDetailVC: ImagePickerDelegate {
    func didSelect(image: UIImage?) {
        
        if let img = image {
            if let status = getStatus() {
                if let key = getImgKey() {
                    self.changeRequestStatus(status: status, airport: nil, flightNo: nil, ident: nil, vesselId: nil, sourcePortId: nil, destinationPortId: nil, imgKey: key, img: img, vesselName: nil , vesselimo: nil, fromAirplane: false) { (msg, success) in
                        
                        self.theTableView.reloadData()
                        print(self.fromDelivered)
//                        if self.fromDelivered{
//                            self.continueToMain()
//                            Toast.show(message: "Trip Completed")
//                        }
//                        guard let req = self.theRequest else { return }
                        
//                        if req.tripStatus == "DROPPED" {
//                            self.showPaymentView = true
//                        }
                        self.checkSetup()
                    }
                }
            }
        }
    }
    

    
    
    func didSelect(videoUrl: NSURL?) {
    }
    
    
}

