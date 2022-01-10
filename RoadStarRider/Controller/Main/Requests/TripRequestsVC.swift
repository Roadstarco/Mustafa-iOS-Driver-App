//
//  TripRequestsVC.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/6/14.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SDWebImage
import CoreLocation

class TripRequestsVC: BaseViewController, Storyboarded {
    
    @IBOutlet weak var lblNoRequest: UILabel!
    @IBOutlet weak var segmentCont: UISegmentedControl!
    @IBOutlet weak var theTableView: UITableView!
    
    var localRequests: [TripRequestData] = [TripRequestData]()
    var internationalRequests: [InternationalRequest] = [InternationalRequest]()
    var showLocalRequests: Bool = true
    
    var currentLat = 33.6678913
    var currentLng = 72.9973065
    
    weak var timer: Timer?
    var timerDispatchSourceTimer : DispatchSourceTimer?
    
    var locationManager: CLLocationManager!
    
    override func setupUI() {

        locationManager = CLLocationManager()
        self.locationSetup()
        registerXibs()
        self.getRequests()
        setupNoData()
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        
        stopTimer()
        startTimer()
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
    
    // if appropriate, make sure to stop your timer in `deinit`
    deinit {
        stopTimer()
    }
    
    func registerXibs() {
        
        let nib = UINib.init(nibName: "TripRequestsCell", bundle: nil)
        theTableView.register(nib, forCellReuseIdentifier: "TripRequestsCell")
        
        let nib1 = UINib.init(nibName: "TripInternationalRequestsCell", bundle: nil)
        theTableView.register(nib1, forCellReuseIdentifier: "TripInternationalRequestsCell")
        
        
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
    
    func getRequests() {
        
        self.getRequests(block: { (msg, status) in
            
            self.setupNoData()
            self.theTableView.reloadData()
        })
    }

}


extension TripRequestsVC {
    
    func getRequests(block: @escaping (String?, Bool)-> Void){
        
//        let pi = ProgressIndicator.show(message: "loading...")
        TheRoute.trip(latitude: String(currentLat), longitude: String(currentLng)).send(TripRequestResponse.self, data: nil, multipleData: nil) { (progress) in
            print(progress)
        } then: { (results) in
//            pi.close()
            switch results {
            case .failure(let error):
                print(error)
                block(error.localizedDescription, false)
                
                
            case .success(let data ):
                print(data)
                if let reqList = data.requests {
                    
                    self.localRequests = reqList
                    print(self.localRequests)
                }
                
                if let internationalReq = data.internationalRequest {
                    
                    self.internationalRequests = internationalReq
                    print(self.internationalRequests)
                }
                
                block(nil, true)
            }
        }
    }
}



extension TripRequestsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.showLocalRequests ? localRequests.count : internationalRequests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if self.showLocalRequests {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TripRequestsCell") as! TripRequestsCell
            
            cell.setUp(request: self.localRequests[indexPath.row], parent: self)
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "TripInternationalRequestsCell") as! TripInternationalRequestsCell
        
        cell.setUp(request: self.internationalRequests[indexPath.row], parent: self)
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let vc = InternationalRequestDetailVC.instantiateMenu()
        vc.fromTripRequests = true
        vc.initialize(request: self.internationalRequests[indexPath.row], theRequest: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
    
}



extension TripRequestsVC: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                currentLat = location.coordinate.latitude
                currentLng = location.coordinate.longitude
                let latString = String(currentLat)
                let lngString = String(currentLng)
                UserDefaults.standard.set(latString, forKey: "lat")
                UserDefaults.standard.set(lngString, forKey: "lng")
                print("Found user's location: \(location)")
                manager.stopUpdatingLocation()
                self.getRequests()
            }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print("Failed to find user's location: \(error.localizedDescription)")
    }
    
    func locationSetup(showAlert: Bool = false){
        let status = CLLocationManager.authorizationStatus()
        
        if status == .notDetermined {
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
            locationManager.requestWhenInUseAuthorization()
            return
        }
        
        if status == .denied || status == .restricted {
            if showAlert {
            
                let alert = UIAlertController(title: "Oops", message: "Need your location.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: {_ in
                    
                    
                }))
                alert.addAction(UIAlertAction(
                    title: "Settings",
                    style: UIAlertAction.Style.default,
                                    handler: {_ in
                                        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else { return }
                                        
                                        if UIApplication.shared.canOpenURL(settingsUrl) {
                                            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                                                print("Settings opened: \(success)") // Prints true
                                            })
                                        }
                                        
                                    }))

                self.present(alert, animated: true, completion: nil)

            }
        }
        
        if status == .authorizedAlways || status == .authorizedWhenInUse {
            locationManager.desiredAccuracy = 1.0
            locationManager.delegate = self
            locationManager.startUpdatingLocation()
        }
    }
}
