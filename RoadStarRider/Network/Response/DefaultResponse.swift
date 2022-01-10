//
//  DefaultResponse.swift
//  Delivery_App
//
//  Created by Rashid on 02/06/2020.
//  Copyright © 2020 Tech Bay Portal. All rights reserved.
//

import Foundation

/// Default response to check for every request since this's how this api works.
struct DefaultResponse: Codable, CodableInit {
    var status: Int
}

//Configured with bitbucket repo
