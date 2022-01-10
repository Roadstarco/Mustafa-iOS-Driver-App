//
//  UserDefaultExtension.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/4/7.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import Foundation

enum UserSessionEnum : String {
    case userSessionData
    case deviceToken
    case userProfile
}

extension UserDefaults{
    //MARK: Save User Data
    func setUserSession(value: Data){
        set(value, forKey: UserSessionEnum.userSessionData.rawValue)
    }
    
    //MARK: Retrieve User Data
    func getUserSession() -> Data?{
        return UserDefaults.standard.value(forKey: UserSessionEnum.userSessionData.rawValue) as? Data
    }
    
    func removeUserSession(){
        self.removeObject(forKey: UserSessionEnum.userSessionData.rawValue)
    }
    
    
    //MARK:- Device token
    func saveDeviceToken(token:String){
        set(token, forKey: UserSessionEnum.deviceToken.rawValue)
    }
    
    func getDeviceToken()-> String?{
        return UserDefaults.standard.value(forKey: UserSessionEnum.deviceToken.rawValue) as? String
    }
    
    func removeDeviceToken(){
        self.removeObject(forKey: UserSessionEnum.deviceToken.rawValue)
    }
    
    
}

extension UserDefaults{
    func isNotificationTaped() -> Bool {
        return UserDefaults.standard.value(forKey: "isNotificationTaped") as? Bool ?? false
    }
    
    func saveIsNotificationTaped(status:Bool){
        set(status, forKey: "isNotificationTaped")
    }
}
