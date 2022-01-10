//
//  TrackPackageVC.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/7/3.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SDWebImage
import Alamofire

class TrackPackageVC: BaseViewController, Storyboarded {
    
    @IBOutlet weak var lblNoRequest: UILabel!
    @IBOutlet weak var segmentCont: UISegmentedControl!
    @IBOutlet weak var theTableView: UITableView!
    
    var localRequests: [TripRequestData] = [TripRequestData]()
    var internationalRequests: [ScheduledTripResponse] = [ScheduledTripResponse]()
    
    var showLocalRequests: Bool = true
    weak var timer: Timer?
    
    var timerDispatchSourceTimer : DispatchSourceTimer?
   
    override func setupUI() {

        registerXibs()
        self.getRequests()
        setupNoData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        stopTimer()
        startTimer()
        
    }
    
    func registerXibs() {
        
        let nib = UINib.init(nibName: "TripRequestsCell", bundle: nil)
        theTableView.register(nib, forCellReuseIdentifier: "TripRequestsCell")
        
        let nib1 = UINib.init(nibName: "TrackPackageCell", bundle: nil)
        theTableView.register(nib1, forCellReuseIdentifier: "TrackPackageCell")
        
        
    }
    
    func setupNoData() {
        
        lblNoRequest.text = "No Request Found"
        if self.showLocalRequests {
            lblNoRequest.isHidden = !(self.localRequests.count == 0)
            
        } else {
            lblNoRequest.isHidden = !(self.internationalRequests.count == 0)
        }
    }
    
    @IBAction func segmentTapped(_ sender: Any) {
        
        if segmentCont.selectedSegmentIndex == 0 {
            showLocalRequests = true
            theTableView.reloadData()
        } else {
            showLocalRequests = false
            theTableView.reloadData()
        }
        
        setupNoData()
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func startTimer() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self?.getRequests()
        }
    }
    
    func stopTimer() {
        timer?.invalidate()
        //timerDispatchSourceTimer?.suspend() // if you want to suspend timer
        timerDispatchSourceTimer?.cancel()
    }
    
    deinit {
        stopTimer()
    }
    
    func getRequests() {
        
        self.getRequest(block: { (msg, status) in
            
            self.theTableView.reloadData()
        })
    }

}


extension TrackPackageVC {
    
    func getRequest(block: @escaping (String?, Bool)-> Void){
        
        let header: HTTPHeaders =
            [
                "Content-Type": "application/json",
                "Accept": "application/json",
                "X-Requested-With": "XMLHttpRequest",
                "Authorization": "Bearer \(UserSession.shared.user?.accessToken ?? "")",
            ]
//        let pi = ProgressIndicator.show(message: "loading...")
        let url = "https://myroadstar.org/api/provider/provider-trips"
        AF.request(url, method: .post, parameters: [:], encoding: URLEncoding.default, headers: header).responseJSON { (response) in
//            pi.closze()
                switch response.result {
                case let .success(value):
                    if let valueData = value as? [[String:Any]] {
                        
                        var allRequests: [ScheduledTripResponse] = [ScheduledTripResponse]()
                        valueData.forEach { (dics) in
                            
                            var payment: ScheduledTripPayment? = nil
                            if let p = dics["payment"] as? [String:Any] {
                                payment = ScheduledTripPayment(id: p["id"] as? Int, tripID: p["trip_id"] as? Int, bidID: p["bid_id"] as? Int, userID: p["user_id"] as? Int, providerID: p["provider_id"] as? Int, fixed: p["fixed"] as? Int, commision: p["commision"] as? Int, tax: p["tax"] as? Int, total: p["total"] as? Int, providerPay: p["provider_pay"] as? Int, paymentID: p["payment_id"] as? String, paymentMode: p["payment_mode"] as? String, cardID: p["card_id"] as? Int, createdAt: p["created_at"] as? String, updatedAt: p["updated_at"] as? String)
                            }
                            
                            
                            
                            let data = ScheduledTripResponse(id: dics["id"] as? Int, bookingID: dics["booking_id"] as? String, providerID: dics["provider_id"] as? Int, userID: dics["user_id"] as? Int, tripfrom: dics["tripfrom"] as? String, tripto: dics["tripto"] as? String, arrivalDate: dics["arrival_date"] as? String, recurrence: dics["recurrence"] as? String, itemSize: dics["item_size"] as? String, item: dics["item"] as? String, itemType: dics["item_type"] as? String, otherInformation: dics["other_information"] as? String, serviceType: dics["service_type"] as? String, vesselID: dics["vessel_id"] as? Int, sourcePortID: dics["source_port_id"] as? Int, destinationPortID: dics["destination_port_id"] as? Int, vesselTrackingCount: dics["vessel_tracking_count"] as? Int, flightNo: dics["flight_no"] as? String, airport: dics["airport"] as? String, flightTrackingCount: dics["flight_tracking_count"] as? Int, tripfromLat: dics["tripfrom_lat"] as? String, tripfromLng: dics["tripfrom_lng"] as? String, triptoLat: dics["tripto_lat"] as? String, triptoLng: dics["tripto_lng"] as? String, tripAmount: dics["trip_amount"] as? Int, receiverName: dics["receiver_name"] as? String, receiverPhone: dics["receiver_phone"] as? String, picture1: dics["picture1"] as? String, picture2: dics["picture2"] as? String, picture3: dics["picture3"] as? String, pickedupImage: dics["pickedup_image"] as? String, droppedofImage: dics["droppedof_image"] as? String, createdBy: dics["created_by"] as? String, tripStatus: dics["trip_status"] as? String, status: dics["status"] as? Int, userRated: dics["user_rated"] as? Int, providerRated: dics["provider_rated"] as? Int, updatedAt: dics["updated_at"] as? String, createdAt: dics["created_at"] as? String, avatar: dics["avatar"] as? String, payment: payment, cardLast4: dics["card_last_4"] as? String, first_name: dics["first_name"] as? String, last_name: dics["last_name"] as? String, email: dics["email"] as? String, picture: dics["picture"] as? String, error: dics["error"] as? String)
                                print(data)
                            if( dics["trip_status"] as! String != "COMPLETED" )
                            {
                            allRequests.append(data)
                            }
                        }
                        
                        self.internationalRequests = allRequests
                        
                        block(nil, true)
                    }else{
                        block(nil, false)
                    }
                case let .failure(error):
                    block(error.localizedDescription, false)
            }
        }
    }
    
}



extension TrackPackageVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.showLocalRequests ? localRequests.count : internationalRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.showLocalRequests {
            stopTimer()
            let cell = tableView.dequeueReusableCell(withIdentifier: "TripRequestsCell") as! TripRequestsCell
            
            cell.setUp(request: self.localRequests[indexPath.row], parent: self)
            
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "TrackPackageCell") as! TrackPackageCell
        
        cell.setUp(request: self.internationalRequests[indexPath.row], parent: self)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if self.internationalRequests[indexPath.row].createdBy == "user" {
            stopTimer()
        let vc = InternationalRequestDetailVC.instantiateMenu()
        vc.reqId = self.internationalRequests[indexPath.row].id ?? 0
        print(self.internationalRequests[indexPath.row].id ?? 0)
        print(vc.reqId)
        vc.initialize(request: nil, theRequest: self.internationalRequests[indexPath.row])
        self.navigationController?.pushViewController(vc, animated: true)
        }
        if self.internationalRequests[indexPath.row].createdBy == "provider" {
            stopTimer()
            let vc = AllAvailableBidsViewController.instantiateMenu()
            vc.internationalRequests = internationalRequests[indexPath.row]
            vc.trip_id = internationalRequests[indexPath.row].id ?? 0
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
}
