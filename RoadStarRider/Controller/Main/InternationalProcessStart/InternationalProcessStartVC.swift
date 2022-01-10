//
//  InternationalProcessStartVC.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/7/3.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SDWebImage
import Alamofire

class InternationalProcessStartVC: BaseViewController, Storyboarded {
    
    @IBOutlet weak var txtAirpoart: SkyFloatingLabelTextField!
    @IBOutlet weak var txtFlightNum: SkyFloatingLabelTextField!
    @IBOutlet weak var theTableView: UITableView!
   
    var searchText: String = ""
    var airpoartList: [AirpoartResponse] = [AirpoartResponse]()
    var selectedAirpoart: AirpoartResponse? = nil
    
    var theDelegate: InternationalRequestDetailProtocol? = nil
    
    override func setupUI() {

        txtAirpoart.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        registerXibs()
    }
    
    func initialize(delegate: InternationalRequestDetailProtocol) {
        
        self.theDelegate = delegate
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {

        if let txt = self.txtAirpoart {
            self.searchText = txt.text ?? ""
            getAllAirpoart()
        }
    }
    
    func getAllAirpoart() {
        
        self.getAirports(block: { (msg, status) in
            self.theTableView.reloadData()
        })
    }
    
    func registerXibs() {
        
        let nib = UINib.init(nibName: "InternationalProcessStartCell", bundle: nil)
        theTableView.register(nib, forCellReuseIdentifier: "InternationalProcessStartCell")
        
    }
    
    @IBAction func btnCancelTapped(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func btnOkeyTapped(_ sender: Any) {
        
        if self.selectedAirpoart == nil {
            Toast.showError(message: "Kindly select airport.")
            return
        } else if self.txtFlightNum.text == nil {
            Toast.showError(message: "Kindly add flight number")
            return
        } else if self.txtFlightNum.text == "" {
            Toast.showError(message: "Kindly add flight number")
            return
        }
        print(selectedAirpoart?.ident as Any)
        
        self.theDelegate?.getData(airport: self.selectedAirpoart!, flight: txtFlightNum.text!, fromAirplane: true)
        
        self.dismiss(animated: true, completion: nil)
    }
    

}


extension InternationalProcessStartVC {
    
    func getAirports(block: @escaping (String?, Bool)-> Void){
        
        if self.searchText.count < 4 {
            return
        }
        
        let header: HTTPHeaders =
            [
                "Content-Type": "application/json",
                "Accept": "application/json",
                "X-Requested-With": "XMLHttpRequest",
                "Authorization": "Bearer \(UserSession.shared.user?.accessToken ?? "")",
            ]
        
        let url = "https://myroadstar.org/api/provider/airports"
        AF.request(url, method: .get, parameters: ["searchTerm": self.searchText], encoding: URLEncoding.default, headers: header).responseJSON { (response) in
                switch response.result {
                case let .success(value):
                    if let valueData = value as? [[String:Any]] {
                        
                        var allAirpoart: [AirpoartResponse] = [AirpoartResponse]()
                        valueData.forEach { (dics) in
                            
                            let a = AirpoartResponse(id: dics["id"] as? Int, ident: dics["ident"] as? String, name: dics["name"] as? String, iata_code: dics["iata_code"] as? String)
                            
                            allAirpoart.append(a)
                            
                        }
                        
                        self.airpoartList = allAirpoart
                        
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



extension InternationalProcessStartVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.airpoartList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InternationalProcessStartCell") as! InternationalProcessStartCell
        
        cell.setup(name: self.airpoartList[indexPath.row].name ?? "")
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        selectedAirpoart = self.airpoartList[indexPath.row]
        print(selectedAirpoart as Any)
        txtAirpoart.text = selectedAirpoart?.name
        self.airpoartList.removeAll()
        self.theTableView.reloadData()
        
    }
    
    
    
}
