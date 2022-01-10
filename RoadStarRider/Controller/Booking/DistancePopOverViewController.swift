//
//  DistancePopOverViewController.swift
//  RoadStar Customer
//
//  Created by Roamer on 21/07/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import GoogleMaps

class DistancePopOverViewController: BaseViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var lblVehicleName: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var vehicleDistance: UILabel!
    
    var image: UIImage!
    var vehicleName: String!
    var totalDistance: String!
    
    override func setupUI() {
        lblVehicleName.text = vehicleName
        imgView.image = image
        vehicleDistance.text = totalDistance
        
        
        // MARK: Define the source latitude and longitude
        let sourceLat = 33.575232
        let sourceLng = 73.032333
            
        // MARK: Define the destination latitude and longitude
        let destinationLat = 33.620121
        let destinationLng = 73.067173
        
        
        
        // MARK: Create source location and destination location so that you can pass it to the URL
//        let sourceLocation = "\(sourceLat),\(sourceLng)"
//        let destinationLocation = "\(destinationLat),\(destinationLng)"
                
//        // MARK: Create URL
//        let url = URL(string: "https://maps.googleapis.com/maps/api/directions/json?origin=\(sourceLocation)&destination=\(destinationLocation)&sensor=true&mode=driving&key=AIzaSyA5l_TkMB4GUvCJx_lNcgz23CjFjdYwmc8")!
//
//
//
//        // MARK: Request for response from the google
//        AF.request(url).responseJSON { (reseponse) in
//            guard let data = reseponse.data else {
//                return
//            }
//
//            do {
//
//                let jsonData = try JSON(data: data)
//                let routes = jsonData["routes"].arrayValue
//
//                for route in routes {
//                    let overview_polyline = route["overview_polyline"].dictionary
//                    let points = overview_polyline?["points"]?.string
//                    let path = GMSPath.init(fromEncodedPath: points ?? "")
//                    let polyline = GMSPolyline.init(path: path)
//                    polyline.strokeColor = .systemBlue
//                    polyline.strokeWidth = 5
//                    polyline.map = self.mapView
//                }
//            }
//             catch let error {
//                print(error.localizedDescription)
//            }
//        }
        
        let sourceMarker = GMSMarker()
        sourceMarker.position = CLLocationCoordinate2D(latitude: sourceLat, longitude: sourceLng)
        sourceMarker.title = ""
        sourceMarker.snippet = ""
        sourceMarker.map = self.mapView
        
        
        // MARK: Marker for destination location
        let destinationMarker = GMSMarker()
        destinationMarker.position = CLLocationCoordinate2D(latitude: destinationLat, longitude: destinationLng)
        destinationMarker.title = ""
        destinationMarker.snippet = ""
        destinationMarker.map = self.mapView
        
        let camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: destinationLat, longitude: destinationLng), zoom: 11)
        self.mapView.animate(to: camera)
    }
    
    override func setupTheme() {
        
    }
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func btnNextTapped(_ sender: Any) {
        
        let packageDetailVC = UIStoryboard.AppStoryboard.Booking.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.Booking.PackageDetailsViewController) as! PackageDetailsViewController
        
        self.navigationController?.pushViewController(packageDetailVC, animated: true)
        
    }
    
}
