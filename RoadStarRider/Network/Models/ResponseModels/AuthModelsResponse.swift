//
//  AuthModelsResponse.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/4/7.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import Foundation
struct on_offlineResponse:  Codable ,CodableInit {
    let id: Int?
    let first_name: String?
    let last_name: String?
    let email: String?
    let gender: String?
    let mobile: String?
    let avatar: String?
    let rating: String?
    let wallet: String?
    let commission_payable: String?
    let status: String?
    let fleet: Int?
    let latitude: Double?
    let longitude: Double?
    let otp: Int?
    let created_at: String?
    let updated_at: String?
    let login_by: String?
    let social_unique_id: String?
    let comp_name: String?
    let comp_reg_no: String?
    let home_address: String?
    let number_of_vehicle:String?
//    let currency: String
//    let sos: String?
    let service: Service?
    let error: String? = nil
    enum CodingKeys: String, CodingKey {
        case id
        case first_name
        case last_name
        case email
        case gender
        case mobile
        case avatar
        case rating
        case wallet
        case commission_payable
        case status
        case fleet
        case latitude
        case longitude
        case otp
        case created_at
        case updated_at
        case login_by
        case social_unique_id
        case comp_name
        case comp_reg_no
        case home_address
        case number_of_vehicle
//        case currency
//        case sos
        case service
        case error
    }
    
}

struct ProfileResponse : Codable, CodableInit {
    
    let id: Int?
    let first_name: String?
    let last_name: String?
    let email: String?
    let gender: String?
    let mobile: String?
    let avatar: String?
    let rating: String?
    let wallet: Double?
    let commission_payable: Double?
    let status: String?
    let fleet: Int?
    let latitude: Double?
    let longitude: Double?
    let otp: Int?
    let created_at: String?
    let updated_at: String?
    let login_by: String?
    let social_unique_id: String?
    let comp_name: String?
    let comp_reg_no: String?
    let home_address: String?
    let number_of_vehicle:String?
    let currency: String?
    let sos: String?
    let documents_uploaded: Bool?
    let service: Service?
    let error: String? = nil
    enum CodingKeys: String, CodingKey {
        case id
        case first_name
        case last_name
        case email
        case gender
        case mobile
        case avatar
        case rating
        case wallet
        case commission_payable
        case status
        case fleet
        case latitude
        case longitude
        case otp
        case created_at
        case updated_at
        case login_by
        case social_unique_id
        case comp_name
        case comp_reg_no
        case home_address
        case number_of_vehicle
        case currency
        case sos
        case documents_uploaded
        case service
        case error
    }
    
}

struct Service: Codable{
    let id: Int?
    let provider_id: Int?
    let service_type_id: Int?
    let status: String?
    let service_number: String?
    let service_model: String?
    let service_type: ServiceType?
    enum CodingKeys: String, CodingKey {
        case id
        case provider_id
        case service_type_id
        case status
        case service_number
        case service_model
        case service_type
    }
    }

struct ServiceType: Codable{
    let id: Int?
    let zones: String?
    let name: String?
    let provider_name: String?
    let image: String?
    let capacity: Int?
    let fixed: String?
    let price: String?
    let minute: String?
    let distance: Int?
    let calculator: String?
    let description: String?
    let status: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case zones
        case name
        case provider_name
        case image
        case capacity
        case fixed
        case price
        case minute
        case distance
        case calculator
        case description
        case status
    }
}


struct OnlyMsgResponse: Codable, CodableInit {
    let message: String?
}

struct SingupModelResponse: Codable, CodableInit {
    let email, firstName, lastName, homeAddress: String?
    let mobile, compName, numberOfVehicle, updatedAt: String?
    let createdAt: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case email
        case firstName = "first_name"
        case lastName = "last_name"
        case homeAddress = "home_address"
        case mobile
        case compName = "comp_name"
        case numberOfVehicle = "number_of_vehicle"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}


// MARK: - Welcome
struct LoginModelResponse: Codable, CodableInit {
    let id: Int
    var firstName, lastName, email, gender: String?
    let mobile: String?
    var avatar: String?
    let rating: String?
    let wallet, commissionPayable: Double?
    let status: String?
    let fleet: Int?
    let latitude, longitude: Double?
    let otp: Int?
    let createdAt, updatedAt, loginBy: String?
    let compName, compRegNo, homeAddress, numberOfVehicle: String?
    let accessToken, currency, sos: String?
    let service: LoginModelResponseService?
    let device: LoginModelResponseDevice?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email, gender, mobile, avatar, rating, wallet
        case commissionPayable = "commission_payable"
        case status, fleet, latitude, longitude, otp
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case loginBy = "login_by"
        case compName = "comp_name"
        case compRegNo = "comp_reg_no"
        case homeAddress = "home_address"
        case numberOfVehicle = "number_of_vehicle"
        case accessToken = "access_token"
        case currency, sos, service, device
    }
}

// MARK: - Device
struct LoginModelResponseDevice: Codable, CodableInit {
    let id, providerID: Int
    let udid, token: String?
    let type: String?

    enum CodingKeys: String, CodingKey {
        case id
        case providerID = "provider_id"
        case udid, token
        case type
    }
}

// MARK: - Service
struct LoginModelResponseService: Codable, CodableInit {
    let id, providerID, serviceTypeID: Int
    let status, serviceNumber, serviceModel: String?

    enum CodingKeys: String, CodingKey {
        case id
        case providerID = "provider_id"
        case serviceTypeID = "service_type_id"
        case status
        case serviceNumber = "service_number"
        case serviceModel = "service_model"
    }
}


struct ProfileUpdatedResponse: Codable, CodableInit {
    let id: Int?
    let firstName, lastName, email, gender: String?
    let mobile, avatar: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case email, gender, mobile, avatar
    }
}


// MARK: - Welcome
struct EarningResponse: Codable, CodableInit {
    let rides, revenue, cancelRides, scheduledRides: Int?
    let internationalRides, internationalRidesRevenue, internationalCancelRides, internationalScheduledRides: Int?

    enum CodingKeys: String, CodingKey {
        case rides, revenue
        case cancelRides = "cancel_rides"
        case scheduledRides = "scheduled_rides"
        case internationalRides, internationalRidesRevenue
        case internationalCancelRides = "international_cancel_rides"
        case internationalScheduledRides = "international_scheduled_rides"
    }
}


struct EarningHistoryResponse: Codable, CodableInit {
    let localJobs: [LocalJob]?
    let internationalJobs: [EarningHistoryInternationalJob]?
}
// MARK: - LocalJob
struct LocalJob: Codable {
    let id: Int?
    let bookingID: String?
    let userID, providerID, currentProviderID, serviceTypeID: Int?
    let status, cancelledBy: String?
    let paymentMode: String?
    let paid: Int?
    let isTrack: String?
    let distance: Int?
    let travelTime, sAddress: String?
    let sLatitude, sLongitude: Double?
    let dAddress: String?
    let dLatitude: Double?
    let trackDistance, trackLatitude, trackLongitude: Int?
    let dLongitude: Double?
    let assignedAt: String?
    let startedAt, finishedAt: String?
    let userRated, providerRated, useWallet, surge: Int?
    let routeKey: String?
    let createdAt, updatedAt, category, productType: String?
    let productWeight, productWidth, productHeight, weightUnit: String?
    let attachment1, attachment2, attachment3: String?
    let pickedupImage, droppedofImage: String?
    let instruction, productDistribution: String?
    let staticMap: String?
    let payment: LocalJobHistoryPayment?

    enum CodingKeys: String, CodingKey {
        case id
        case bookingID = "booking_id"
        case userID = "user_id"
        case providerID = "provider_id"
        case currentProviderID = "current_provider_id"
        case serviceTypeID = "service_type_id"
        case status
        case cancelledBy = "cancelled_by"
        case paymentMode = "payment_mode"
        case paid
        case isTrack = "is_track"
        case distance
        case travelTime = "travel_time"
        case sAddress = "s_address"
        case sLatitude = "s_latitude"
        case sLongitude = "s_longitude"
        case dAddress = "d_address"
        case dLatitude = "d_latitude"
        case trackDistance = "track_distance"
        case trackLatitude = "track_latitude"
        case trackLongitude = "track_longitude"
        case dLongitude = "d_longitude"
        case assignedAt = "assigned_at"
        case startedAt = "started_at"
        case finishedAt = "finished_at"
        case userRated = "user_rated"
        case providerRated = "provider_rated"
        case useWallet = "use_wallet"
        case surge
        case routeKey = "route_key"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case category
        case productType = "product_type"
        case productWeight = "product_weight"
        case productWidth = "product_width"
        case productHeight = "product_height"
        case weightUnit = "weight_unit"
        case attachment1, attachment2, attachment3
        case pickedupImage = "pickedup_image"
        case droppedofImage = "droppedof_image"
        case instruction
        case productDistribution = "product_distribution"
        case staticMap = "static_map"
        case payment
    }
}
//Configured with bitbucket repo

// MARK: - LocalJobPayment
struct LocalJobHistoryPayment: Codable {
    let id, requestID: Int?
    let paymentID, paymentMode: String?
    let fixed, distance: Int?
    let commision: Double?
    let discount, tax, wallet, surge: Int?
    let total, payable: Int?
    let providerCommission, providerPay: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case requestID = "request_id"
        case paymentID = "payment_id"
        case paymentMode = "payment_mode"
        case fixed, distance, commision, discount, tax, wallet, surge, total, payable
        case providerCommission = "provider_commission"
        case providerPay = "provider_pay"
    }
}

// MARK: - InternationalJob
struct EarningHistoryInternationalJob: Codable, CodableInit {
    let id: Int?
    let bookingID: String?
    let providerID, userID: Int?
    let tripfrom, tripto, arrivalDate, itemSize: String?
    let item, itemType, otherInformation, serviceType: String?
    let vesselTrackingCount: Int?
    let flightNo, airport: String?
    let flightTrackingCount, tripAmount: Int?
    let receiverName, receiverPhone, picture1, picture2: String?
    let picture3: String?
    let pickedupImage, droppedofImage: String?
    let createdBy, tripStatus: String?
    let status, userRated, providerRated: Int?
    let updatedAt, createdAt: String?
    let payment: EarningHistoryPayment?
    let tripRequest: EarningHistoryTripRequest?

    enum CodingKeys: String, CodingKey {
        case id
        case bookingID = "booking_id"
        case providerID = "provider_id"
        case userID = "user_id"
        case tripfrom, tripto
        case arrivalDate = "arrival_date"
        case itemSize = "item_size"
        case item
        case itemType = "item_type"
        case otherInformation = "other_information"
        case serviceType = "service_type"
        case vesselTrackingCount = "vessel_tracking_count"
        case flightNo = "flight_no"
        case airport
        case flightTrackingCount = "flight_tracking_count"
        case tripAmount = "trip_amount"
        case receiverName = "receiver_name"
        case receiverPhone = "receiver_phone"
        case picture1, picture2, picture3
        case pickedupImage = "pickedup_image"
        case droppedofImage = "droppedof_image"
        case createdBy = "created_by"
        case tripStatus = "trip_status"
        case status
        case userRated = "user_rated"
        case providerRated = "provider_rated"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case payment
        case tripRequest = "trip_request"
    }
}

// MARK: - Payment
struct EarningHistoryPayment: Codable, CodableInit {
    let id, tripID, bidID, userID: Int?
    let providerID, fixed, tax: Int?
    let commision, providerPay: Double?
    let total: Int?
    let paymentID, paymentMode: String?
    let cardID: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case tripID = "trip_id"
        case bidID = "bid_id"
        case userID = "user_id"
        case providerID = "provider_id"
        case fixed, commision, tax, total
        case providerPay = "provider_pay"
        case paymentID = "payment_id"
        case paymentMode = "payment_mode"
        case cardID = "card_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

// MARK: - TripRequest
struct EarningHistoryTripRequest: Codable, CodableInit {
    let id, userID, providerID, tripID: Int?
    let item, itemType, picture1, picture2: String?
    let picture3: String?
    let amount: Int?
    let travellerResponse, serviceType, createdBy, status: String?
    let receiverName, receiverPhone, updatedAt, createdAt: String?
    let counterAmount, isCounter: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case userID = "user_id"
        case providerID = "provider_id"
        case tripID = "trip_id"
        case item
        case itemType = "item_type"
        case picture1, picture2, picture3, amount
        case travellerResponse = "traveller_response"
        case serviceType = "service_type"
        case createdBy = "created_by"
        case status
        case receiverName = "receiver_name"
        case receiverPhone = "receiver_phone"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case counterAmount = "counter_amount"
        case isCounter = "is_counter"
    }
}


// MARK: - WelcomeElement
struct DocumentsResponse: Codable, CodableInit {
    let id, providerID: Int?
    let documentID, documentName, url, status: String?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case providerID = "provider_id"
        case documentID = "document_id"
        case documentName = "document_name"
        case url, status
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}

typealias DocumentsResponseLias = [DocumentsResponse]


struct TripRequestResponse: Codable, CodableInit {
    let accountStatus, serviceStatus: String?
    let requests: [TripRequestData]?
    let internationalRequest: [InternationalRequest]?

    enum CodingKeys: String, CodingKey {
        case accountStatus = "account_status"
        case serviceStatus = "service_status"
        case requests
        case internationalRequest = "user_trips"
    }
}

struct InternationalRequest: Codable, CodableInit {
    let id: Int?
    let bookingID: String?
    let providerID, userID: Int?
    let tripfrom, tripto, arrivalDate, item: String?
    let itemSize, itemType, otherInformation: String?
    let vesselTrackingCount, flightTrackingCount, tripAmount: Int?
    let receiverName, receiverPhone, picture1, picture2: String?
    let picture3, pickedupImage, droppedofImage, createdBy: String?
    let tripStatus: String?
    let status, userRated, providerRated: Int?
    let updatedAt, createdAt, firstName, lastName: String?
    let email: String?
    let bid_details: bidDetails?

    enum CodingKeys: String, CodingKey {
        case id
        case bookingID = "booking_id"
        case providerID = "provider_id"
        case userID = "user_id"
        case tripfrom, tripto
        case arrivalDate = "arrival_date"
        case item
        case itemSize = "item_size"
        case itemType = "item_type"
        case otherInformation = "other_information"
        case vesselTrackingCount = "vessel_tracking_count"
        case flightTrackingCount = "flight_tracking_count"
        case tripAmount = "trip_amount"
        case receiverName = "receiver_name"
        case receiverPhone = "receiver_phone"
        case picture1, picture2, picture3
        case pickedupImage = "pickedup_image"
        case droppedofImage = "droppedof_image"
        case createdBy = "created_by"
        case tripStatus = "trip_status"
        case status
        case userRated = "user_rated"
        case providerRated = "provider_rated"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case firstName = "first_name"
        case lastName = "last_name"
        case email
        case bid_details
    }
}

struct bidDetails: Codable, CodableInit{
    let id: Int?
    let user_id: String?
    let provider_id: Int?
    let trip_id: Int?
    let item: String?
    let send_from: String?
    let send_to: String?
    let item_type: String?
    let item_size: String?
    let picture1: String?
    let picture2: String?
    let picture3: String?
    let description: String?
    let amount: Int?
    let traveller_response: String?
    let service_type: String?
    let created_by: String?
    let status: String?
    let receiver_name: String?
    let receiver_phone: String?
    let updated_at: String?
    let created_at: String?
    let counter_amount: Int?
    let is_counter: Int?
    
    
}


// MARK: - RequestElement
struct TripRequestData: Codable, CodableInit {
    let id, requestID, providerID, status: Int?
    let timeLeftToRespond: Int?
    let request: TripRequestUserData?

    enum CodingKeys: String, CodingKey {
        case id
        case requestID = "request_id"
        case providerID = "provider_id"
        case status
        case timeLeftToRespond = "time_left_to_respond"
        case request
    }
}



// MARK: - RequestRequest
struct TripRequestUserData: Codable, CodableInit {
    let id: Int?
    let bookingID: String?
    let userID, providerID, currentProviderID, serviceTypeID: Int?
    let status, cancelledBy: String?
    let paymentMode: String?
    let paid: Int?
    let isTrack: String?
    let distance: Int?
    let sAddress: String?
    let sLatitude, sLongitude: Double?
    let dAddress: String?
    let dLatitude: Double?
    let trackDistance, trackLatitude, trackLongitude: Int?
    let dLongitude: Double?
    let assignedAt: String?
    let startedAt, finishedAt: String?
    let userRated, providerRated, useWallet, surge: Int?
    let routeKey: String?
    let createdAt, updatedAt, category, productType: String?
    let productWeight, productWidth, productHeight, weightUnit: String?
    let attachment1, attachment2, attachment3: String?
    let pickedupImage, droppedofImage: String?
    let instruction, productDistribution, receiverName, receiverPhone: String?
    let user: TripRequestUser?
    let payment: TripRequestPayment?

    enum CodingKeys: String, CodingKey {
        case id
        case bookingID = "booking_id"
        case userID = "user_id"
        case providerID = "provider_id"
        case currentProviderID = "current_provider_id"
        case serviceTypeID = "service_type_id"
        case status
        case cancelledBy = "cancelled_by"
        case paymentMode = "payment_mode"
        case paid
        case isTrack = "is_track"
        case distance
        case sAddress = "s_address"
        case sLatitude = "s_latitude"
        case sLongitude = "s_longitude"
        case dAddress = "d_address"
        case dLatitude = "d_latitude"
        case trackDistance = "track_distance"
        case trackLatitude = "track_latitude"
        case trackLongitude = "track_longitude"
        case dLongitude = "d_longitude"
        case assignedAt = "assigned_at"
        case startedAt = "started_at"
        case finishedAt = "finished_at"
        case userRated = "user_rated"
        case providerRated = "provider_rated"
        case useWallet = "use_wallet"
        case surge
        case routeKey = "route_key"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
        case category
        case productType = "product_type"
        case productWeight = "product_weight"
        case productWidth = "product_width"
        case productHeight = "product_height"
        case weightUnit = "weight_unit"
        case attachment1, attachment2, attachment3
        case pickedupImage = "pickedup_image"
        case droppedofImage = "droppedof_image"
        case instruction
        case productDistribution = "product_distribution"
        case receiverName = "receiver_name"
        case receiverPhone = "receiver_phone"
        case user, payment
    }
}

// MARK: - Payment
struct TripRequestPayment: Codable, CodableInit {
    let id, requestID: Int?
    let paymentID, paymentMode: String?
    let fixed, distance: Int?
    let commision: Double?
    let discount, tax, wallet, surge: Int?
    let total, payable: Int?
    let providerCommission, providerPay: Double?

    enum CodingKeys: String, CodingKey {
        case id
        case requestID = "request_id"
        case paymentID = "payment_id"
        case paymentMode = "payment_mode"
        case fixed, distance, commision, discount, tax, wallet, surge, total, payable
        case providerCommission = "provider_commission"
        case providerPay = "provider_pay"
    }
}

// MARK: - User
struct TripRequestUser: Codable, CodableInit {
    let id: Int?
    let firstName, lastName, paymentMode, email: String?
    let gender, mobile: String?
    let picture: String?
    let points: Int?
    let deviceID, deviceType, loginBy: String?
    let stripeCustID: String?
    let walletBalance: Int?
    let rating: String?
    let otp: Int?
    let updatedAt: String?
    let isReferralUsed: Int?
    let countryName, address: String?

    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case paymentMode = "payment_mode"
        case email, gender, mobile, picture, points
        case deviceID = "device_id"
        case deviceType = "device_type"
        case loginBy = "login_by"
        case stripeCustID = "stripe_cust_id"
        case walletBalance = "wallet_balance"
        case rating, otp
        case updatedAt = "updated_at"
        case isReferralUsed = "is_referral_used"
        case countryName = "country_name"
        case address
    }
}



// MARK: - User
struct NormalSimpleResponse: Codable, CodableInit {
    let id: Int?
    
}

// MARK: - User
struct NormalMsgSimpleResponse: Codable, CodableInit {
    let message: String?
    
}



struct BidUserResponse: Codable, CodableInit {
    
    let providerID: Int?
    let serviceType, tripID, travellerResponse, amount: String?
    let status, createdBy, updatedAt, createdAt: String?
    let id: Int?

    enum CodingKeys: String, CodingKey {
        case providerID = "provider_id"
        case serviceType = "service_type"
        case tripID = "trip_id"
        case travellerResponse = "traveller_response"
        case amount, status
        case createdBy = "created_by"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case id
    }
}

typealias ScheduledTripList = [ScheduledTripResponse]

struct ScheduledTripResponse: Codable, CodableInit {
    let id: Int?
    let bookingID: String?
    let providerID: Int?
    let userID: Int?
    let tripfrom, tripto, arrivalDate: String?
    let recurrence: String?
    let itemSize: String?
    let item, itemType: String?
    let otherInformation, serviceType: String?
    let vesselID: Int?
    let sourcePortID, destinationPortID: Int?
    let vesselTrackingCount: Int?
    let flightNo: String?
    let airport: String?
    let flightTrackingCount: Int?
    let tripfromLat, tripfromLng, triptoLat, triptoLng: String?
    let tripAmount: Int?
    let receiverName, receiverPhone: String?
    let picture1: String?
    let picture2, picture3: String?
    let pickedupImage, droppedofImage: String?
    let createdBy, tripStatus: String?
    let status, userRated, providerRated: Int?
    let updatedAt, createdAt: String?
    let avatar: String?
    let payment: ScheduledTripPayment?
    let cardLast4: String?
    let first_name: String?
    let last_name: String?
    let email: String?
    let picture: String?
    let error: String?
    enum CodingKeys: String, CodingKey {
        case id
        case bookingID = "booking_id"
        case providerID = "provider_id"
        case userID = "user_id"
        case tripfrom, tripto
        case arrivalDate = "arrival_date"
        case recurrence
        case itemSize = "item_size"
        case item
        case itemType = "item_type"
        case otherInformation = "other_information"
        case serviceType = "service_type"
        case vesselID = "vessel_id"
        case sourcePortID = "source_port_id"
        case destinationPortID = "destination_port_id"
        case vesselTrackingCount = "vessel_tracking_count"
        case flightNo = "flight_no"
        case airport
        case flightTrackingCount = "flight_tracking_count"
        case tripfromLat = "tripfrom_lat"
        case tripfromLng = "tripfrom_lng"
        case triptoLat = "tripto_lat"
        case triptoLng = "tripto_lng"
        case tripAmount = "trip_amount"
        case receiverName = "receiver_name"
        case receiverPhone = "receiver_phone"
        case picture1, picture2, picture3
        case pickedupImage = "pickedup_image"
        case droppedofImage = "droppedof_image"
        case createdBy = "created_by"
        case tripStatus = "trip_status"
        case status
        case userRated = "user_rated"
        case providerRated = "provider_rated"
        case updatedAt = "updated_at"
        case createdAt = "created_at"
        case avatar, payment
        case cardLast4 = "card_last_4"
        case first_name = "first_name"
        case last_name = "last_name"
        case email = "email"
        case picture = "picture"
        case error = "error"
    }
}

struct ScheduledTripPayment: Codable, CodableInit {
    let id, tripID, bidID, userID: Int?
    let providerID, fixed, commision, tax: Int?
    let total, providerPay: Int?
    let paymentID, paymentMode: String?
    let cardID: Int?
    let createdAt, updatedAt: String?

    enum CodingKeys: String, CodingKey {
        case id
        case tripID = "trip_id"
        case bidID = "bid_id"
        case userID = "user_id"
        case providerID = "provider_id"
        case fixed, commision, tax, total
        case providerPay = "provider_pay"
        case paymentID = "payment_id"
        case paymentMode = "payment_mode"
        case cardID = "card_id"
        case createdAt = "created_at"
        case updatedAt = "updated_at"
    }
}


struct AirpoartResponse: Codable {
    let id: Int?
    let ident, name: String?
    let iata_code: String?
}


struct ShipResponse: Codable {
    let marine_traffic_id: Int?
    let name: String?
    let imo: Int?
}



struct AvailableTripBidsResponse: Codable, CodableInit{
    
    let id: Int?
    let user_id: Int?
    let provider_id: Int?
    let trip_id: Int?
    let item: String?
    let send_from: String?
    let send_to: String?
    let item_type: String?
    let item_size: String?
    let picture1: String?
    let picture2: String?
    let picture3: String?
    let description: String?
    let amount: Int?
    let traveller_response: String?
    let service_type: String?
    let created_by: String?
    let status: String?
    let receiver_name: String?
    let receiver_phone: String?
    let updated_at: String?
    let created_at: String?
    let counter_amount: Int?
    let is_counter: Int?
    let trip_service_type: String?
    let first_name: String?
    let last_name: String?
    let email: String?
    let picture: String?
    let mobile: String?
    
    enum CodingKeys: String, CodingKey {
     case id
     case user_id
     case provider_id
     case trip_id
     case item
     case send_from
     case send_to
     case item_type
     case item_size
     case picture1
     case picture2
     case picture3
     case description
     case amount
     case traveller_response
     case service_type
     case created_by
     case status
     case receiver_name
     case receiver_phone
     case updated_at
     case created_at
     case counter_amount
     case is_counter
     case trip_service_type
     case first_name
     case last_name
     case email
     case picture
     case mobile
    
    }

}
 struct AcceptBidResponse: Codable, CodableInit{
     
     let id: Int?
     let user_id: Int?
     let provider_id: Int?
     let trip_id: Int?
     let item: String?
     let send_from: String?
     let send_to: String?
     let item_type: String?
     let item_size: String?
     let picture1: String?
     let picture2: String?
     let picture3: String?
     let description: String?
     let amount: Int?
     let traveller_response: String?
     let service_type: String?
     let created_by: String?
     let status: String?
     let receiver_name: String?
     let receiver_phone: String?
     let updated_at: String?
     let created_at: String?
     let counter_amount: Int?
     let is_counter: Int?
}


struct GetCurrentStatusResponse: Codable, CodableInit{
    
    let Trip: trip?
    
}

struct trip: Codable, CodableInit{
    
    let id: Int?
    let booking_id: String?
    let provider_id: Int?
    let user_id: Int?
    let tripfrom: String?
    let tripto: String?
    let arrival_date: String?
    let recurrence: String?
    let item_size: String?
    let item: String?
    let item_type: String?
    let other_information: String?
    let service_type: String?
    let vessel_id: String?
    let vessel_imo: String?
    let vessel_name: String?
    let source_port_id: String?
    let destination_port_id: String?
    let vessel_tracking_count: Int?
    let flight_no: String?
    let departure_time: String?
    let airport: String?
    let flight_tracking_count: Int?
    let tripfrom_lat: String?
    let tripfrom_lng: String?
    let tripto_lat: String?
    let tripto_lng: String?
    let trip_amount: Int?
    let receiver_name: String?
    let receiver_phone: String?
    let picture1: String?
    let picture2: String?
    let picture3: String?
    let pickedup_image: String?
    let droppedof_image: String?
    let created_by: String?
    let trip_status: String?
    let status: Int?
    let user_rated: Int?
    let provider_rated: Int?
    let updated_at: String?
    let created_at: String?
    let bid_details: bidDetails1?
    let avatar: String?
    let first_name: String?
    let last_name: String?
    let email: String?
    let picture: String?
    
}
struct bidDetails1: Codable, CodableInit{
    let id: Int?
    let user_id: Int?
    let provider_id: Int?
    let trip_id: Int?
    let item: String?
    let send_from: String?
    let send_to: String?
    let item_type: String?
    let item_size: String?
    let picture1: String?
    let picture2: String?
    let picture3: String?
    let description: String?
    let amount: Int?
    let traveller_response: String?
    let service_type: String?
    let created_by: String?
    let status: String?
    let receiver_name: String?
    let receiver_phone: String?
    let updated_at: String?
    let created_at: String?
    let counter_amount: Int?
    let is_counter: Int?
    
    
}
struct DocumentList: Codable, CodableInit{
    let id: Int?
    let name: String?
    let type: String?
    
}
