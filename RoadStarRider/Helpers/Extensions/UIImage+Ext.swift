//
//  UIImage+Ext.swift
//  RoadStar Customer
//
//  Created by Roamer on 12/07/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import Foundation
import UIKit

extension UIImage {
    
    enum AppImages {
        static let DeliveryHomeIcon = "FillStar"
        
        enum Booking {
            enum DeliveryModes {
                static let Cycle    = "Bicycle"
                static let Scooter  = "Scooter"
                static let Car      = "Car"
            }
        }
        
        enum Settings {
            static let Home            = "Home"
            static let ManageVehicle   = "ManageVehicle"
            static let Documents       = "Documents"
            static let History         = "History"
            static let Earning         = "Earning"
            static let PaymentMethod   = "PaymentMethod"
            static let ContectUs       = "ContectUs"
            static let Logout          = "Logout"
            static let Message         = "message"
        }
    }
    
}
