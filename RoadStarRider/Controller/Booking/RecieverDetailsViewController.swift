//
//  RecieverDetailsViewController.swift
//  RoadStar Customer
//
//  Created by Roamer on 21/07/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import UIKit

class RecieverDetailsViewController: BaseViewController {

    override func setupUI() {
        
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    @IBAction func btnNextTapped(_ sender: Any) {
        
        let paymentOptionsVC = UIStoryboard.AppStoryboard.Booking.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.Booking.BookingPaymentOptionsViewController) as! BookingPaymentOptionsViewController
        
        self.navigationController?.pushViewController(paymentOptionsVC, animated: true)
    
    }

}
