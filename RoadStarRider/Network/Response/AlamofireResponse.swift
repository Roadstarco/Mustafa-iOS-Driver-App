//
//  AlamofireResponse.swift
//  Delivery_App
//
//  Created by Rashid on 02/06/2020.
//  Copyright © 2020 Tech Bay Portal. All rights reserved.
//

import Alamofire

// MARK: - This extension I spotted in the Quicktype site, so I gave it a look and I don't think it's so good anyway, due to error handling, not so good. so just here for demonstraition.
extension DataRequest {
    
    @discardableResult
    /// Generalized version of the original function
    ///
    /// - Parameters:
    ///   - dumb: Codable model.
    ///   - queue: not necessary.
    ///   - completionHandler: response with object in value, errors otherwise.
    /// - Returns: returns the request, but ignore that.
    func response<T: Decodable>(_ dumb: T.Type, queue: DispatchQueue = .main, completionHandler: @escaping (AFDataResponse<T>) -> Void) -> Self {
        return self.responseDecodable(queue: queue, completionHandler: completionHandler)
    }
    
//    @discardableResult
//    func responseSwiftCairoUser(queue: DispatchQueue = .main, completionHandler: @escaping (AFDataResponse<SwiftCairoUser>) -> Void) -> Self {
//        return self.responseDecodable(queue: queue, completionHandler: completionHandler)
//    }
}
//Configured with bitbucket repo

