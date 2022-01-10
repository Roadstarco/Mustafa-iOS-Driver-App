//
//  CodableInit.swift
//  Delivery_App
//
//  Created by Rashid on 02/06/2020.
//  Copyright © 2020 Tech Bay Portal. All rights reserved.
//

import Foundation

protocol CodableInit: Codable {
    init(data: Data) throws
}

extension CodableInit  {
    init(data: Data) throws {
        let decoder = JSONDecoder()

        self = try decoder.decode(Self.self, from: data)
    }
}

//Configured with bitbucket repo

