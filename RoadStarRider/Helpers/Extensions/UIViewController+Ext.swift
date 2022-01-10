//
//  UIViewController+Ext.swift
//  RoadStar Customer
//
//  Created by Roamer on 12/07/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import Foundation
import UIKit

/// UIViewController extension
/// Extension for adding **Identifiers** to UIViewController.
extension UIViewController {
    /**
     
     All UIViewControllers which are used across the app have their **Identifiers** defined here
     
     */
    enum Identifiers {
        
        // MARK: Based on StoryBoards
        
        enum PreLogin {
            static let SignInViewController         = "SigninViewController"
            static let SignUpViewController         = "SignUpViewController"
            static let VerifyOTPViewController      = "VerifyOTPViewController"
            static let SignupDetailsViewController  = "SignupDetailsViewController"
            static let ForgetPasswordViewController = "ForgetPasswordViewController"
            static let SignUpTypeVC = "SignUpTypeVC"
            static let UploadDocumentsViewController = "UploadDocumentsViewController"
            
        }
        
        enum Main {
            static let LaunchScreenViewController   = "LaunchScreenViewController"
            static let MainViewController           = "MainViewController"
            static let LeftMenuViewController       = "LeftMenuViewController"
        }
        
        enum Home {
            static let HomeViewController = "HomeViewController"
        }
        
        enum Booking {
            static let RatingViewController                 = "RatingViewController"
            static let BookingViewController                = "BookingViewController"
            static let PackageDetailsViewController         = "PackageDetailsViewController"
            static let DistancePopOverViewController        = "DistancePopOverViewController"
            static let RecieverDetailsViewController        = "RecieverDetailsViewController"
            static let BookingPaymentOptionsViewController  = "BookingPaymentOptionsViewController"
        }
        
        enum Dialog {
            static let CustomForgotPasswordViewController = "CustomForgotPasswordViewController"
        }
        
        enum Menu {
            static let BaseViewController               = "BaseViewController"
            static let ClaimViewController              = "ClaimViewController"
            static let SupportViewController            = "SupportNav"
            static let TrackPackageViewController       = "TrackPackageViewController"
            static let BookingHistoryViewController     = "BookingHistoryViewController"
            static let PaymentMethodsViewController     = "PaymentMethodsViewController"
            static let OfferCounterViewController       = "OfferCounterViewController"
            static let MessageViewController            = "MessageViewController"
        }
    }
    
    enum Titles {
        static let Home = ""
    }
}
