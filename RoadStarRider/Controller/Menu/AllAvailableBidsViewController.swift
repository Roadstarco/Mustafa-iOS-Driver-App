//
//  AllAvailableBidsViewController.swift
//  RoadStarRider
//
//  Created by Apple on 14/12/2021.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import Foundation
import UIKit
import Alamofire

class AllAvailableBidsViewController: BaseViewController, Storyboarded{
    
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var theTableView: UITableView!
    @IBOutlet weak var lblNoBids: UILabel!
    
    var trip_id = 0
    var allBids: [AvailableTripBidsResponse] = []
    weak var timer: Timer?
    var timerDispatchSourceTimer : DispatchSourceTimer?
    var internationalRequests: ScheduledTripResponse?
    override func setupUI() {
        getTripBids()
        lblNoBids.isHidden = true
        registerXibs()
        theTableView.delegate = self
        theTableView.dataSource = self
        self.theTableView.reloadData()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        stopTimer()
        startTimer()
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        stopTimer()
        
    }
    
    func registerXibs(){
        
        let nib = UINib.init(nibName: "AvailableTripBidsCell", bundle: nil)
        theTableView.register(nib, forCellReuseIdentifier: "AvailableTripBidsCell")
        
    }
    
    func startTimer() {
        
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self?.getTripBids()
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
    
    func getTripBids() {
        
        let url = "https://myroadstar.org/api/provider/trip-bids"
        
        let header: HTTPHeaders =
            [
                "Content-Type": "application/json",
                "Accept": "application/json",
                "X-Requested-With": "XMLHttpRequest",
                "Authorization": "Bearer \(UserSession.shared.user?.accessToken ?? "")",
            ]
        let params = AvailableTripBidsRequest(trip_id: self.trip_id)
        AF.request(url, method: .post, parameters: params, encoder: JSONParameterEncoder.default, headers: header).validate(statusCode: 200..<600).validate(contentType: ["application/json"]).responseDecodable(of: [AvailableTripBidsResponse].self) { (response) in
            
            switch response.result{
            case .success(let results):
                print(results)
                self.allBids = results
                self.theTableView.reloadData()
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    
    

    
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension AllAvailableBidsViewController: UITableViewDataSource, UITableViewDelegate{
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return allBids.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AvailableTripBidsCell") as! AvailableTripBidsCell
        cell.setUp(result: allBids[indexPath.row], parent: self )
        cell.internationalRequests = self.internationalRequests
        
        return cell
    }
    
    
    
    
    
    
}
