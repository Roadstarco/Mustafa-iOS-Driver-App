//
//  PackageDetailsViewController.swift
//  RoadStar Customer
//
//  Created by Roamer on 21/07/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import UIKit
import iOSDropDown

class PackageDetailsViewController: BaseViewController {

    @IBOutlet weak var txtWeight: UITextField!
    @IBOutlet weak var dropDownProductType: DropDown!
    @IBOutlet weak var dropDownCategory: DropDown!
    @IBOutlet weak var imgView: UIImageView!
    
    
    override func setupUI() {
        
        dropDownProductType.optionArray = ["Product 1", "Product 2", "Product 3", "Product 4", "Product 5", "Product 6", "Product 7", "Product 8", "Product 9", "Product 10"]
        dropDownProductType.rowBackgroundColor = Theme.dropDownColor
        
        dropDownCategory.optionArray = ["Category 1", "Category 2", "Category 3", "Category 4", "Category 5", "Category 6", "Category 7", "Category 8", "Category 9", "Category 10"]
        dropDownCategory.rowBackgroundColor = Theme.dropDownColor
    }
    
    override func setupTheme() {
        super.setupTheme()
    }
    
    @IBAction func btnAttachmentTapped(_ sender: Any) {
    }
    
    @IBAction func btnNextTapped(_ sender: Any) {
    
        let recieverDetailVC = UIStoryboard.AppStoryboard.Booking.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.Booking.RecieverDetailsViewController) as! RecieverDetailsViewController
        
        self.navigationController?.pushViewController(recieverDetailVC, animated: true)
    
    }
    
}
