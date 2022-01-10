//
//  TheRoute.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/4/7.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import Foundation
import Alamofire


enum TheRoute: URLRequestBuilder {
    //Configured with bitbucket repo

    case updateFCM(fcm: String)
    case on_ofLine(status: UserStatus)
    case getProfile
    case acceptCounter(trip_id: Int, bid_id: Int)
    case rejectCounter(trip_id: Int, bid_id: Int)
    case signup(user:SingupModel)
    case login(user:LoginModel)
    case updateProfile(firstName: String, secName: String, email: String, mobile: String)
    case updatePassword(pass: String, confPass: String, oldPass: String)
    case sendSupport(subject: String, message: String)
    case summary
    case history
    case document
    case trip(latitude: String, longitude: String)
    case acceptRequest(reqId: String, method: String?, status: String?, airport: String?, flightNo: String?, vesselId: String?, sourcePortId: String?, destinationPortId: String?)
    case acceptInternationalRequest(reqId: String, method: String, status: String, airport: String?, flightNo: String?, ident: String?, vesselId: Int?, sourcePortId: String?, destinationPortId: String?, vessel_name: String?, vessel_imo: Int?)
    
    case rateTripUser(tripId: String, rating: String, comment: String)
    case rateLocalTripUser(tripId: String, rating: String, comment: String)
    case bidUser(tripId: String, serviceType: String, travellerResponse: String, amount: String)
    case updateTrip(id: String, status: String)
    case scheduledTrips
    case uploadDocument(documentId: String, documentName: String)
    case postTrip(tripfrom: String, tripto: String, service_type: String, item_size: String, arrival_date:String, return_date: String, other_information: String)
    case tripBids(trip_id: Int)
    case acceptBid(bid_id: Int, trip_id: Int, traveller_response: String, status: String)
    case offerCounter(bid_id: Int, counter_amount: String)
    case getTripDetails(trip_id: Int, uid: Int)
    case sendMsg(user_id: Int)
    internal var path: String {
        switch self {
        case .on_ofLine:
            return "profile/available"
        case .getProfile:
            return "profile"
        case .signup:
            return "register"
        case .login:
            return "oauth/token"
        case .updateProfile:
            return "profile"
        case .updatePassword:
            return "profile/password"
        case .sendSupport(subject: let subject, message: let message):
            return "send-support-message-provider"
        case .summary:
            return "summary"
        case .history:
            return "requests/history"
        case .document:
            return "documents/display-provider-documents"
        case .trip:
            return "trip"
        case .acceptRequest(let id, _, _, _, _, _, _, _):
            return "trip/\(id)"
        case .acceptInternationalRequest:
            return "update-trip"
        case .rateTripUser:
            return "rate-trip-user"
        case .bidUser:
            return "bid-user-trip"
        case .scheduledTrips:
            return "provider-trips"
        case .rateLocalTripUser(let id, _, _):
            return "trip/\(id)/rate"
        case .uploadDocument:
            return "documents/upload"
        case .postTrip:
            return "post-trip"
        case .updateFCM:
            return "profile/update/profile/fcm"
        case .updateTrip:
            return "update-trip"
            
        case .acceptCounter:
            return "bid/counter-accept"
        case .rejectCounter:
            return "bid/counter-reject"
        case .tripBids:
            return "trip-bids"
        case .acceptBid:
            return "update-bid"
            
        case .offerCounter( let bid_id, let counter_amount):
            return "bid/counter-offer"
        case .getTripDetails( let trip_id, let uid):
            return "trip-details-new"
        case .sendMsg(user_id: let user_id):
            return "send-message-notification-to-user"
        }
    }
    
    // MARK: - Parameters
    internal var parameters: Parameters? {
        var params = Parameters.init()
        switch self {
        
        case .login(let user):
            
            params["grant_type"] = user.grantType
            params["client_id"] = user.clientID
            params["client_secret"] = user.clientSecret
            params["email"] = user.email
            params["password"] = user.password
            params["scope"] = user.scope
            
        case .signup(let user):
            
            params["password"] = user.password
            params["email"] = user.email
            params["password_confirmation"] = user.password_confirmation
            params["first_name"] = user.first_name
            params["last_name"] = user.last_name
            params["home_address"] = user.home_address
            params["mobile"] = user.mobile
            params["login_by"] = user.login_by
            
        case .updateProfile(let fName, let sName, let email, let mobile):
            
            params["first_name"] = fName
            params["last_name"] = sName
            params["email"] = email
            params["mobile"] = mobile
            
        case .updatePassword(let pass, let confPass, let oldPass):
            
            params["password"] = pass
            params["password_confirmation"] = confPass
            params["password_old"] = oldPass
            
        case .sendSupport(let subject, let message):
            
            params["subject"] = subject
            params["message"] = message
            
        case .summary:
            break
            
        case .history:
            break
            
        case .document:
            break
            
        case .trip(let latitude, let longitude):
            
            params["latitude"] = latitude
            params["longitude"] = longitude
            
        case .acceptRequest(_, let method, let status, let airport, let flightNo, let vesselId, let sourcePortId, let destinationPortId):
            
            if method != nil {
                params["_method"] = method
            }
            if status != nil {
                params["status"] = status
            }
            if airport != nil {
                params["airport"] = airport
            }
            if flightNo != nil {
                params["flight_no"] = flightNo
            }
            if vesselId != nil {
                params["vessel_id"] = vesselId
            }
            if sourcePortId != nil {
                params["source_port_id"] = sourcePortId
            }
            if destinationPortId != nil {
                params["destination_port_id"] = destinationPortId
            }
//            (reqId: String, method: String, status: String, airport: String?, flightNo: String?, ident: String?, vesselId: Int?, sourcePortId: String?, destinationPortId: String?, vessel_name: String?, vessel_imo: Int?)
            
//            (let id, let method, let status, let airport, let flightNo, let vesselId, let sourcePortId, let destinationPortId, let ident, let vessel_name, let vessel_imo )
        case .acceptInternationalRequest(let id, let method, let status, let airport, let flightNo, let ident, let vesselId, let sourcePortId, let destinationPortId, let vessel_name, let vessel_imo ):
            print(method as Any)
            print(ident as Any)
            print(vesselId as Any)
            params["trip_id"] = id
            params["trip_status"] = status
            if airport != nil {
                params["airport"] = airport
            }
            if ident != nil {
                params["ident"] = ident
            }
            if flightNo != nil {
                params["flight_no"] = flightNo
            }
            if vesselId != nil {
                params["vesselId"] = vesselId
            }
            if sourcePortId != nil {
                params["source_port_id"] = sourcePortId
            }
            if destinationPortId != nil {
                params["destination_port_id"] = destinationPortId
            }
            if vessel_name != nil {
                params["vessel_name"] = vessel_name
            }
            if vessel_imo != nil{
                params["vessel_imo"] = vessel_imo

            }
            
        case .rateTripUser(let tripId, let rating, let comment):
            params["trip_id"] = tripId
            params["rating"] = rating
            params["comment"] = comment
            
        case .bidUser(let tripId, let serviceType, let travellerResponse, let amount):
            params["trip_id"] = tripId
            params["service_type"] = serviceType
            params["traveller_response"] = travellerResponse
            params["amount"] = amount
            
        case .scheduledTrips:
            break
            
        case .rateLocalTripUser(_, let rating, let comment):
            params["rating"] = rating
            params["comment"] = comment
            
        case .uploadDocument(let documentId, let documentName):
            params["document_id"] = ["\(documentId)"]
            params["document_name"] = ["\(documentName)"]
            
            
        case .postTrip(let tripfrom, let tripto, let service_type, let item_size, let arrival_date, let return_date, let other_information):
            params["tripfrom"] = tripfrom
            params["tripto"] = tripto
            params["service_type"] = service_type
            params["item_size"] = item_size
            params["arrival_date"] = arrival_date
            params["return_date"] = return_date
            params["other_information"] = other_information
        case .on_ofLine(let status):
            params["service_status"] = status.service_status
        
            
        case .getProfile:
            break
        case .updateFCM(let fcm):
            params["fcm"] = fcm
        case .updateTrip( let id,  let status):
            params["trip_id"] = id
            params["trip_status"] = status
        case .acceptCounter( let trip_id,  let bid_id):
            params["trip_id"] = trip_id
            params["bid_id"] = bid_id
        case .rejectCounter( let trip_id,  let bid_id):
            params["trip_id"] = trip_id
            params["bid_id"] = bid_id
        case .tripBids(let trip_id):
            params["trip_id"] = trip_id
        case .acceptBid( let bid_id, let trip_id, let traveller_response, let status):
            params["trip_id"] = trip_id
            params["bid_id"] = bid_id
            params["traveller_response"] = traveller_response
            params["status"] = status
        case .offerCounter( let bid_id,  let counter_amount):
            params["bid_id"] = bid_id
            params["counter_amount"] = counter_amount
        case .getTripDetails( let trip_id,  let uid):
            params["trip_id"] = trip_id
            params["uid"] = uid
            
        case .sendMsg( let user_id):
            params["user_id"] = user_id
        }
        
        let deviceId = UIDevice.current.identifierForVendor?.uuidString ?? ""
        params["device_id"] = deviceId
        params["device_type"] = "ios"
        params["device_token"] = UserDefaults.standard.getDeviceToken() ?? "deviceId"
        print(params)
        return params
    }
    
    // MARK: - Methods
    internal var method: HTTPMethod {
        switch self {
        
        case .history, .document, .trip, .getProfile:
            return .get
        default:
            return .post
        }
    }
    // MARK: - HTTPHeaders
    internal var headers: HTTPHeaders {
        let header:HTTPHeaders =
            [
                "Content-Type": "application/json",
                "Accept": "application/json",
                "X-Requested-With": "XMLHttpRequest",
                "Authorization": "Bearer \(UserSession.shared.user?.accessToken ?? "")",
            ]
        print(UserSession.shared.user?.accessToken ?? "no token")
        switch self {
        default:
            return header
        }
    }
    
}
