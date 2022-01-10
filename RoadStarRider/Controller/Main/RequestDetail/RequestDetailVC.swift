//
//  RequestDetailVC.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/6/14.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SDWebImage
import Alamofire

class RequestDetailVC: BaseViewController, Storyboarded {
    
    @IBOutlet weak var theTableView: UITableView!
    
    var localRequest: TripRequestData!
    var theRequest: TripRequestUserData? = nil
    
    func initialize(localRequest: TripRequestData) {
        self.localRequest = localRequest
    }
    
    override func setupUI() {

        guard let req = self.localRequest.request else { return }
        
        if req.status != "SEARCHING" {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                
                let vc = UIStoryboard.AppStoryboard.Menu.instance.instantiateViewController(withIdentifier: "RequestMapDetailVC") as! RequestMapDetailVC
                vc.initialize(localRequest: req)
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        registerXibs()
    }
    
    func registerXibs() {
        
        let nib = UINib.init(nibName: "RequestDetailCell", bundle: nil)
        theTableView.register(nib, forCellReuseIdentifier: "RequestDetailCell")
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}


extension RequestDetailVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RequestDetailCell") as! RequestDetailCell
        
        cell.setUp(request: self.localRequest, parent: self)
        
        return cell
        
    }
    
    
    
}


extension RequestDetailVC {
    
    func acceptRequest(block: @escaping (String?, Bool)-> Void){
        
        guard let id = localRequest.requestID else { return }
        let header: HTTPHeaders =
            [
                "Content-Type": "application/json",
                "Accept": "application/json",
                "X-Requested-With": "XMLHttpRequest",
                "Authorization": "Bearer \(UserSession.shared.user?.accessToken ?? "")",
            ]
        
        let url = "https://myroadstar.org/api/provider/trip/\(id)"
        let pi = ProgressIndicator.show(message: "loading...")
        AF.request(url, method: .post, parameters: [:], encoding: URLEncoding.default, headers: header).responseJSON { (response) in
            pi.close()
                switch response.result {
                case let .success(value):
                    if let valueData = value as? [[String:Any]] {
                        
                        var allRequests: [TripRequestUserData] = [TripRequestUserData]()
                        valueData.forEach { (dics) in
                            
                            let payment: TripRequestPayment? = nil
                            let user: TripRequestUser? = nil
                            
                            let data = TripRequestUserData(id: dics["id"] as? Int, bookingID: dics["booking_id"] as? String, userID: dics["user_id"] as? Int, providerID: dics["provider_id"] as? Int, currentProviderID: dics["current_provider_id"] as? Int, serviceTypeID: dics["service_type_id"] as? Int, status: dics["status"] as? String, cancelledBy: dics["cancelled_by"] as? String, paymentMode: dics["payment_mode"] as? String, paid: dics["paid"] as? Int, isTrack: dics["is_track"] as? String, distance: dics["distance"] as? Int, sAddress: dics["s_address"] as? String, sLatitude: dics["s_latitude"] as? Double, sLongitude: dics["s_longitude"] as? Double, dAddress: dics["d_address"] as? String, dLatitude: dics["d_latitude"] as? Double, trackDistance: dics["track_distance"] as? Int, trackLatitude: dics["track_latitude"] as? Int, trackLongitude: dics["track_longitude"] as? Int, dLongitude: dics["d_longitude"] as? Double, assignedAt: dics["assigned_at"] as? String, startedAt: dics["started_at"] as? String, finishedAt: dics["finished_at"] as? String, userRated: dics["user_rated"] as? Int, providerRated: dics["provider_rated"] as? Int, useWallet: dics["use_wallet"] as? Int, surge: dics["surge"] as? Int, routeKey: dics["route_key"] as? String, createdAt: dics["created_at"] as? String, updatedAt: dics["updated_at"] as? String, category: dics["category"] as? String, productType: dics["product_type"] as? String, productWeight: dics["product_weight"] as? String, productWidth: dics["product_width"] as? String, productHeight: dics["product_height"] as? String, weightUnit: dics["weight_unit"] as? String, attachment1: dics["attachment1"] as? String, attachment2: dics["attachment2"] as? String, attachment3: dics["attachment3"] as? String, pickedupImage: dics["pickedup_image"] as? String, droppedofImage: dics["droppedof_image"] as? String, instruction: dics["instruction"] as? String, productDistribution: dics["product_distribution"] as? String, receiverName: dics["receiver_name"] as? String, receiverPhone: dics["receiver_phone"] as? String, user: user, payment: payment)
                                
                            allRequests.append(data)
                            
                        }
                        
                        let req = allRequests.first { (r) -> Bool in
                            r.id == id
                        }
                          
                        self.theRequest = req
                        
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
