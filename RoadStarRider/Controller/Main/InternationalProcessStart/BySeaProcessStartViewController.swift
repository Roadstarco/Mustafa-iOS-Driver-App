//
//  BySeaProcessStartViewController.swift
//  RoadStarRider
//
//  Created by Apple on 23/12/2021.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SDWebImage
import Alamofire

class BySeaProcessStartViewController: BaseViewController, Storyboarded {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchAirport: UITextField!
    
    var searchText: String = ""
    var shipList: [ShipResponse] = []
    var selectedShip: ShipResponse? = nil
    var theDelegate: InternationalRequestDetailProtocol? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
       // getAllShips()
        tableView.delegate = self
    }
    
    func initialize(delegate: InternationalRequestDetailProtocol) {
        
        self.theDelegate = delegate
    }
    
    @objc func textFieldDidChange(_ textField: UITextField) {

        if let txt = self.searchAirport {
            self.searchText = txt.text ?? ""
            if( self.searchText.count > 2)
                
            {getAllShips()}
        }
    }
        
//
    override func setupUI() {

        searchAirport.addTarget(self, action: #selector(self.textFieldDidChange(_:)), for: .editingChanged)
        registerXibs()
    }
    func registerXibs() {
        
        let nib = UINib.init(nibName: "InternationalProcessStartCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: "InternationalProcessStartCell")
        
    }
    
    func getAllShips() {
        
        let header: HTTPHeaders =
            [
                "Content-Type": "application/json",
                "Accept": "application/json",
                "X-Requested-With": "XMLHttpRequest",
                "Authorization": "Bearer \(UserSession.shared.user?.accessToken ?? "")",
            ]
        
        let url = "https://myroadstar.org/api/provider/vessels"
        AF.request(url, method: .get, parameters: ["searchTerm": self.searchText], encoding: URLEncoding.default, headers: header).responseJSON { (response) in
                switch response.result {
                case let .success(value):
                    if let valueData = value as? [[String:Any]] {
                        
                        var allships: [ShipResponse] = [ShipResponse]()
                        valueData.forEach { (dics) in
                            
                            let a = ShipResponse(marine_traffic_id: dics["marine_traffic_id"] as? Int, name: dics["name"] as? String, imo: dics["imo"] as? Int)
                            
                            allships.append(a)
                            
                        }
                        
                        self.shipList = allships
                        self.tableView.reloadData()
                        
                        
                    }else{
                        print("here")
                    }
                case let .failure(error):
                    print(error)
            }
        }
    }
    
    @IBAction func cancelTapped(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)

    }
    
    @IBAction func okTapped(_ sender: UIButton) {
        if self.selectedShip == nil {
            Toast.showError(message: "Kindly select airport.")
            return
        }
        print(selectedShip?.marine_traffic_id as Any)
        
        self.theDelegate?.getDataSea(ship: self.selectedShip!,  fromShip: true)
        
        self.dismiss(animated: true, completion: nil)
    }
    
}




extension BySeaProcessStartViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.shipList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "InternationalProcessStartCell") as! InternationalProcessStartCell
        
        cell.setup(name: self.shipList[indexPath.row].name ?? "")
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        selectedShip = self.shipList[indexPath.row]
        print(selectedShip as Any)
        searchAirport.text = selectedShip?.name
        self.shipList.removeAll()
        self.tableView.reloadData()
        
    }
    
    
    
}
