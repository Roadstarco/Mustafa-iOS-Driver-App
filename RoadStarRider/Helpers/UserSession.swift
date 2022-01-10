//
//  UserSession.swift
//  Alazba
//
//  Created by Myansh Passi on 18/11/20.
//

import Foundation

class UserSession:NSObject {
    private static let _shared = UserSession()
    static var shared : UserSession {
        return _shared
    }
    var isShowingTracking = false
    var user : LoginModelResponse?{
        didSet{
            do {
                guard let user = user else {return}
                let data = try JSONEncoder().encode(user)
                UserDefaults.standard.setUserSession(value: data)
            }catch let error {
                print(error)
            }
            print(user?.accessToken ?? "")
        }
    }
    
    func logOut() {
        UserDefaults.standard.removeUserSession()
    }
}

enum UserTypeEnum: String {
    case guest
    case normalStudent
    case advanceStudent
}
