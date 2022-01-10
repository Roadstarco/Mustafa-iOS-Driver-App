//
//  InternationalRequestDetailProtocol.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/7/5.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import Foundation

protocol InternationalRequestDetailProtocol {
    
    func getData(airport: AirpoartResponse, flight: String, fromAirplane: Bool)
    func getDataSea(ship: ShipResponse,  fromShip: Bool)

    
}
