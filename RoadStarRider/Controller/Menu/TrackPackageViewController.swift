//
//  TrackPackageViewController.swift
//  RoadStar Customer
//
//  Created by Roamer on 21/07/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import UIKit
import GoogleMaps

class TrackPackageViewController: BaseViewController {

    @IBOutlet weak var mapView: GMSMapView!
    
    
    override func setupUI() {
        
        // MARK: Define the source latitude and longitude
        let sourceLat = 33.575232
        let sourceLng = 73.032333
            
        // MARK: Define the destination latitude and longitude
        let destinationLat = 33.620121
        let destinationLng = 73.067173
        
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
        super.setupTheme()
        
    }

    @IBAction func btnChatTapped(_ sender: Any) {
        
    }
}
