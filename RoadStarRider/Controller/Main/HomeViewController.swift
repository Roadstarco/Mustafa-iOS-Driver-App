//
//  HomeViewController.swift
//  RoadStar Customer
//
//  Created by Roamer on 04/07/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import UIKit
import CoreLocation

class HomeViewController: BaseViewController {
    
    
    // MARK: Variables, Constants And Outlets
    
    @IBOutlet weak var btnOkey: UIButton!
    @IBOutlet weak var lblNote: UILabel!
    @IBOutlet weak var vwCount: UIView!
    @IBOutlet weak var lblCount: UILabel!
    @IBOutlet weak var localDeliveryView: HomeDeliveryOptionsView!
    @IBOutlet weak var earningView: HomeDeliveryOptionsView!
    @IBOutlet weak var historyView: HomeDeliveryOptionsView!
        
    @IBOutlet weak var on_ofLineBtn: UISwitch!
    @IBOutlet weak var vwAlert: UIView!
    
    
    var localRequests: [TripRequestData] = [TripRequestData]()
    var internationalRequest: [InternationalRequest] = [InternationalRequest]()
    
    // MARK: Private Functions
    var currentLat = 33.6678913
    var currentLng = 72.9973065
    
    var locationManager: CLLocationManager!
    
    weak var timer: Timer?
    var timerDispatchSourceTimer : DispatchSourceTimer?
    
    func setupButtons() {
        
        lblCount.text = "\(localRequests.count + internationalRequest.count)"
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        if UserDefaults.standard.bool(forKey: "on_offBtnStatus") == true {
//            on_ofLineBtn.setOn(true, animated: false)
//
//        }else if UserDefaults.standard.bool(forKey: "on_offBtnStatus") == false {
//            on_ofLineBtn.setOn(false, animated: false)
//
//        }
        
        stopTimer()
        startTimer()
    }
    

    
    
    @IBAction func on_ofBtnTapped(_ sender: Any) {
        if on_ofLineBtn.isOn{
            
            UserDefaults.standard.set(true, forKey: "on_offBtnStatus")
            let status = UserStatus(service_status: "active")
            
            TheRoute.on_ofLine(status: status).send(on_offlineResponse.self) { (results) in
                print("result is\(results)")
                switch results {
                    
                case .failure(let error):
                    print("error is\(error)")
                    
                    
                case .success(let data ):
                    print(data)
                }
            }
                
        }else{
            
            UserDefaults.standard.set(false, forKey: "on_offBtnStatus")
            let status = UserStatus(service_status: "offline")
            
            TheRoute.on_ofLine(status: status).send(on_offlineResponse.self) { (results) in
                print("result is\(results)")
                switch results {
                case .failure(let error):
                    print("error is\(error.localizedDescription)")
                    
                    
                case .success(let data ):
                    print(data)
                }
            }

            
            
        }
        
        
    }
    
    @IBAction func btnOkeyTapped(_ sender: Any) {
        
        self.vwAlert.isHidden = true
    }
    
    
    override func setupUI() {
        self.updateFcmApi()
        self.getProflieAPI()
        let user = UserSession.shared.user
        self.vwAlert.isHidden = true
        
        if user?.status == "onboarding" {
            self.vwAlert.isHidden = false
            lblNote.text = "Your account has not been approved yet!"
        } else if user?.status == "banned" {
            self.vwAlert.isHidden = false
            lblNote.text = "Your account has been banned!"
        }
        
        locationManager = CLLocationManager()
        self.locationSetup()
        startTimer()
        
        let gestureLocal = UITapGestureRecognizer(target: self, action:  #selector(self.onClickLocalDelivery))
        self.localDeliveryView.addGestureRecognizer(gestureLocal)
        
        let gestureEarning = UITapGestureRecognizer(target: self, action:  #selector(self.onClickEarnings(_:)))
        self.earningView.addGestureRecognizer(gestureEarning)
        
        let gestureHistory = UITapGestureRecognizer(target: self, action:  #selector(self.onClickHistory(_:)))
        self.historyView.addGestureRecognizer(gestureHistory)
    }
    
    func getProflieAPI(){
        
        TheRoute.getProfile.send(ProfileResponse.self, data: nil, multipleData: nil) { (progress) in
            print(progress)
        } then: { (results) in
            print(results)
            switch results {
            case .failure(let error):
                print(error)
                
                
            case .success(let data ):
                print(data)
                print(data.id as Any)
                let uid = data.id! as Int
                print(uid)
                let uidString = String(uid)
                print(uidString)
                UserDefaults.standard.set(uidString, forKey: "uid")
                print(UserDefaults.standard.string(forKey: "uid") as Any)
                
                if data.service?.status == "offline"{
                    
                        
                    self.on_ofLineBtn.setOn(false, animated: false)
                        
                    
                    
                } else if data.service?.status == "active"{
                    
                    self.on_ofLineBtn.setOn(true, animated: false)
                    
                   }
                }
            }
        }
    
    func updateFcmApi(){
        
        TheRoute.updateFCM(fcm: UserDefaults.standard.value(forKey: "fcmToken") as! String).send(OnlyMsgResponse.self) { (results) in
            switch results {
            case .failure(let error):
                print(error)
                
                
            case .success(let data ):
                print(data)
            }
        }
    }
    
    
    func startTimer() {
        
        guard let user = UserSession.shared.user else { return }
        if user.status == "onboarding" || user.status == "banned" {
            return
        }
        timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { [weak self] _ in
            self?.getRequests(block: { (msg, status) in
                self?.setupButtons()
            })
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
    

    // MARK: Action Functions
    
    @objc func onClickLocalDelivery(_ sender:UITapGestureRecognizer){
        
//        if self.localRequests.count == 0 && self.internationalRequest.count == 0 {
//            Toast.showError(message: "You have no request to show.")
//            return
//        }
        self.stopTimer()
        let vc = UIStoryboard.AppStoryboard.Menu.instance.instantiateViewController(withIdentifier: "TripRequestsVC") as! TripRequestsVC
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func onClickEarnings(_ sender:UITapGestureRecognizer){
        
        
        let vc = EarningVC.instantiateMenu()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    @objc func onClickHistory(_ sender:UITapGestureRecognizer){
        
        let vc = HistoryVC.instantiateMenu()
        self.navigationController?.pushViewController(vc, animated: true)

    }
    
    
    
    // MARK: - App Flow Functions
    
}



extension HomeViewController {
    
    func getRequests(block: @escaping (String?, Bool)-> Void){
        
        TheRoute.trip(latitude: String(currentLat), longitude: String(currentLng)).send(TripRequestResponse.self, data: nil, multipleData: nil) { (progress) in
            print(progress)
        } then: { (results) in
            
            switch results {
            case .failure(let error):
                print(error)
                block(error.localizedDescription, false)
                
                
            case .success(let data):
                print(data)
                if let reqList = data.requests {
                    
                    self.localRequests = reqList
                }
                if let ir = data.internationalRequest {
                    self.internationalRequest = ir
                }
                block(nil, true)
            }
        }
    }
}


extension HomeViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
            if let location = locations.first {
                currentLat = location.coordinate.latitude
                currentLng = location.coordinate.longitude
                UserDefaults.standard.set(self.currentLat, forKey: "currentLat")
                UserDefaults.standard.set(self.currentLng, forKey: "currentLng")

                print("Found user's location: \(location)")
                manager.stopUpdatingLocation()
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
