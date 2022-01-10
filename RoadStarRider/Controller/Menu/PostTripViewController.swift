//
//  PostTripViewController.swift
//  RoadStarRider
//
//  Created by Apple on 22/11/2021.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import Foundation
import iOSDropDown
import UIKit
import GoogleMaps
import CoreLocation
import GooglePlacesSearchController

class PostTripViewController: BaseViewController{
    
    @IBOutlet weak var vwArivalDate: UIView!
    @IBOutlet weak var vwReturnDate: UIView!
    @IBOutlet weak var vwTripFrom: UIView!
    @IBOutlet weak var vwTripTo: UIView!
    @IBOutlet weak var vwItemSize: UIView!
    @IBOutlet weak var vwServiceType: UIView!
    @IBOutlet weak var vwParcelDetails: UIView!
    @IBOutlet weak var arrivalDate: UITextField!
    @IBOutlet weak var returnDate: UITextField!
    @IBOutlet weak var tripFrom: UITextField!
    @IBOutlet weak var tripTo: UITextField!
    @IBOutlet weak var itemSizeDrpDwn: DropDown!
    @IBOutlet weak var serviceType: DropDown!
    @IBOutlet weak var parcelDetails: UITextView!
    let GoogleMapsAPIServerKey = "AIzaSyCO--TQ_iF9WC2_Gv7KgjasEmnEoxwbF-E"
    var fromArrivalDate = false
    lazy var placesSearchController: GooglePlacesSearchController = {
        let controller = GooglePlacesSearchController(delegate: self,
                                                      apiKey: GoogleMapsAPIServerKey,
                                                      placeType: .all
                                                      
            // Optional: coordinate: CLLocationCoordinate2D(latitude: 55.751244, longitude: 37.618423),
            // Optional: radius: 10,
            // Optional: strictBounds: true,
            // Optional: searchBarPlaceholder: "Start typing..."
        )
        tripFrom.isUserInteractionEnabled = false
        tripTo.isUserInteractionEnabled = false
        //Optional: controller.searchBar.isTranslucent = false
        //Optional: controller.searchBar.barStyle = .black
        //Optional: controller.searchBar.tintColor = .white
        //Optional: controller.searchBar.barTintColor = .black
        return controller
    }()
    
    override func setupUI(){
        itemSizeDrpDwn.optionArray = ["Small", "Medium", "Large", "Extra Large"]
        itemSizeDrpDwn.rowBackgroundColor = Theme.dropDownColor
        
        serviceType.optionArray = ["By Road", "By Sea", "By Air"]
        serviceType.rowBackgroundColor = Theme.dropDownColor
        
        vwArivalDate.layer.borderWidth = 1
        vwArivalDate.layer.borderColor = UIColor.red.cgColor
        
        vwReturnDate.layer.borderWidth = 1
        vwReturnDate.layer.borderColor = UIColor.red.cgColor
        
        vwTripFrom.layer.borderWidth = 1
        vwTripFrom.layer.borderColor = UIColor.red.cgColor
        
        vwTripTo.layer.borderWidth = 1
        vwTripTo.layer.borderColor = UIColor.red.cgColor
        
        vwItemSize.layer.borderWidth = 1
        vwItemSize.layer.borderColor = UIColor.red.cgColor
        
        vwServiceType.layer.borderWidth = 1
        vwServiceType.layer.borderColor = UIColor.red.cgColor
        
        vwParcelDetails.layer.borderWidth = 1
        vwParcelDetails.layer.borderColor = UIColor.red.cgColor
        
        //@objc func selectors for textfield taps
        arrivalDate.addTarget(self, action: #selector(arrivalDateTapped), for: .touchDown)
        returnDate.addTarget(self, action: #selector(returnDateTapped), for: .touchDown)
        tripFrom.addTarget(self, action: #selector(tripFromTapped), for: .touchDown)
        tripTo.addTarget(self, action: #selector(triptoTapped), for: .touchDown)
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    @objc func arrivalDateTapped(){
        
        RPicker.selectDate(title: "Select Date & Time", cancelText: "Cancel", datePickerMode: .date, minDate: Date(), maxDate: Date().dateByAddingYears(10000), style: .Inline, didSelectDate: {[weak self] (selectedDate) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM-dd-YYYY"
            let stringDate = dateFormatter.string(from: selectedDate)
            print(stringDate)
            self?.arrivalDate.text = stringDate
            
        })
    }
    
    @objc func returnDateTapped(){
        
        RPicker.selectDate(title: "Select Date ", cancelText: "Cancel", datePickerMode: .date, minDate: Date(), maxDate: Date().dateByAddingYears(10000), style: .Inline, didSelectDate: {[weak self] (selectedDate) in
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "MMM-dd-YYYY"
            let stringDate = dateFormatter.string(from: selectedDate)
            print(stringDate)
            self?.returnDate.text = stringDate
        })
    }
    
    @objc func tripFromTapped(){
        self.fromArrivalDate = true
        self.present(placesSearchController, animated: true, completion: nil)
        
    }
    
    @objc func triptoTapped(){
        self.fromArrivalDate = false
        self.present(placesSearchController, animated: true, completion: nil)
        
    }
    
    @IBAction func btnPostTapped(_ sender: Any) {
        if isValidate(){
        postTripApi{(msg, status) in
        
        }
      }
    }
    
    
    func continueToMain() {

        let homeNav = UIStoryboard.AppStoryboard.Main.instance.instantiateViewController(withIdentifier: UINavigationController.Identifiers.HomeNav) as! UINavigationController
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(homeNav, animated: true, completion: nil)
    }
    
    func postTripApi(_ block: @escaping (String?, Bool)-> Void){
    
        let pi = ProgressIndicator.show(message: "loading...")
        
        
        TheRoute.postTrip(tripfrom: self.tripFrom.text ?? "", tripto: self.tripTo.text ?? "", service_type: self.serviceType.text ?? "", item_size: self.itemSizeDrpDwn.text ?? "", arrival_date:arrivalDate.text ?? "", return_date: returnDate.text ?? "", other_information: parcelDetails.text ?? "").send(OnlyMsgResponse.self) { (results) in
            pi.close()
            switch results {
            case .failure(let error):
                print(error)
                block(error.localizedDescription, false)
                Toast.showError(message: "Something went wrong")
                
            case .success(let data ):
                print(data)
                Toast.show(message: "Trip Posted Successfully")
                self.continueToMain()
                block(nil, true)
            }
        }
    }
    
    func isValidate() -> Bool {
        
        if tripFrom.text == nil {
            Toast.showError(message: "Please Enter Disparture Location")
            return false
        } else if tripFrom.text!.isEmpty {
            Toast.showError(message: "Please Enter Disparture Location")
            return false
        } else if tripTo.text == nil {
            Toast.showError(message: "Please Enter Destination")
            return false
        } else if tripTo.text!.isEmpty {
            Toast.showError(message: "Please Enter Destination")
            return false
        }else if serviceType.text == nil {
            Toast.showError(message: "Please Select Service Type")
            return false
        } else if serviceType.text!.isEmpty {
            Toast.showError(message: "Please Select Service Type")
            return false
        }else if itemSizeDrpDwn.text == nil {
            Toast.showError(message: "Please Select Item Size")
            return false
        } else if itemSizeDrpDwn.text!.isEmpty {
            Toast.showError(message: "Please Select Item Size")
            return false
        }else if arrivalDate.text == nil {
            Toast.showError(message: "Please Enter Arrival Date")
            return false
        } else if arrivalDate.text!.isEmpty {
            Toast.showError(message: "Please Enter Arrival Date")
            return false
        }else if returnDate.text == nil {
            Toast.showError(message: "Please Enter Return Date")
            return false
        } else if returnDate.text!.isEmpty {
            Toast.showError(message: "Please Enter Return Date")
            return false
        }else if parcelDetails.text == nil {
            Toast.showError(message: "Please Enter Parcel Details")
            return false
        } else if parcelDetails.text!.isEmpty {
            Toast.showError(message: "Please Enter Parcel Details")
            return false
        }
        
        return true
        
    }
    
    
}
extension PostTripViewController: GooglePlacesAutocompleteViewControllerDelegate {
    func viewController(didAutocompleteWith place: PlaceDetails) {
        if fromArrivalDate == true{
            tripFrom.text = place.name
        }else{
            tripTo.text = place.name
            
        }
        self.dismiss(animated: true)
        tripFrom.isUserInteractionEnabled = true
        tripTo.isUserInteractionEnabled = true
//        tripFrom.isEnabled = false
//        tripTo.isEnabled = false
    }
    

    
    
    
}
extension Date {
    func dateString(_ format: String = "MMM-dd-YYYY") -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = format
    return dateFormatter.string(from: self)
  }
  func dateByAddingYears(_ dYears: Int) -> Date {
    var dateComponents = DateComponents()
    dateComponents.year = dYears
    return Calendar.current.date(byAdding: dateComponents, to: self)!
  }
}
extension UITextView {
    func centerVertically() {
        let fittingSize = CGSize(width: bounds.width, height: CGFloat.greatestFiniteMagnitude)
        let size = sizeThatFits(fittingSize)
        let topOffset = (bounds.size.height - size.height * zoomScale) / 2
        let positiveTopOffset = max(1, topOffset)
        contentOffset.y = -positiveTopOffset
    }
}
