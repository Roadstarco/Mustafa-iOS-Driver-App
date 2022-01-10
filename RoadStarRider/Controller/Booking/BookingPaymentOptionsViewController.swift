//
//  BookingPaymentOptionsViewController.swift
//  RoadStar Customer
//
//  Created by Roamer on 21/07/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import UIKit

class BookingPaymentOptionsViewController: BaseViewController {

    override func setupUI() {
        
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    @IBAction func btnNextTapped(_ sender: Any) {
        
        let ratingVC = UIStoryboard.AppStoryboard.Booking.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.Booking.RatingViewController) as! RatingViewController
        
        self.navigationController?.pushViewController(ratingVC, animated: true)
    
    }

}
