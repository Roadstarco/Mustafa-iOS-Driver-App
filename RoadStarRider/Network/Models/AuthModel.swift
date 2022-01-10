//
//  AuthModel.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/4/7.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import Foundation

struct SingupModel:Codable {
    
    let password: String
    let email: String
    let password_confirmation: String
    let first_name, last_name, home_address, mobile: String
    let login_by, comp_name, number_of_vehicle: String
}
//Configured with bitbucket repo

struct LoginModel: Codable {
    let grantType: String
    let clientID: Int
    let clientSecret, email, password, scope: String
}
