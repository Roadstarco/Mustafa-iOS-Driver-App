//
//  BookingViewController.swift
//  RoadStar Customer
//
//  Created by Roamer on 16/07/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import UIKit
import GoogleMaps

class BookingViewController: BaseViewController {

    @IBOutlet weak var mapView: GMSMapView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    override func setupUI() {
        self.collectionView.register(UINib(nibName: ModeCollectionViewCell.nibName, bundle: Bundle.main), forCellWithReuseIdentifier: ModeCollectionViewCell.cellReuseIdentifier)
        
        let sourceLat = 33.5651
        let sourceLng = 73.0169
        let camera = GMSCameraPosition(target: CLLocationCoordinate2D(latitude: sourceLat, longitude: sourceLng), zoom: 11)
        self.mapView.animate(to: camera)
    }
    
}

extension BookingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ModeCollectionViewCell.cellReuseIdentifier, for: indexPath) as? ModeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        if indexPath.item == 0 {
            cell.mainLabel.text = "Cycle"
            cell.mainImageView.image = UIImage(named: UIImage.AppImages.Booking.DeliveryModes.Cycle)
        }
        else if indexPath.item == 1 {
            cell.mainLabel.text = "Scooter"
            cell.mainImageView.image = UIImage(named: UIImage.AppImages.Booking.DeliveryModes.Scooter)
        }
        else {
            cell.mainLabel.text = "Car"
            cell.mainImageView.image = UIImage(named: UIImage.AppImages.Booking.DeliveryModes.Car)
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.item == 0 {
            
            let distanceVC = UIStoryboard.AppStoryboard.Booking.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.Booking.DistancePopOverViewController) as! DistancePopOverViewController
            
            
            let img = UIImage(named: UIImage.AppImages.Booking.DeliveryModes.Cycle)
            distanceVC.image = img
            distanceVC.vehicleName = "Vehicle Cycle"
            distanceVC.totalDistance = "Total Distance: 124 KM"
            
            self.navigationController?.pushViewController(distanceVC, animated: true)
            
        }
        else if indexPath.item == 1 {
            
            let distanceVC = UIStoryboard.AppStoryboard.Booking.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.Booking.DistancePopOverViewController) as! DistancePopOverViewController
            
            
            let img = UIImage(named: UIImage.AppImages.Booking.DeliveryModes.Scooter)
            distanceVC.image = img
            distanceVC.vehicleName = "Vehicle Scooter"
            distanceVC.totalDistance = "Total Distance: 124 KM"
            
            self.navigationController?.pushViewController(distanceVC, animated: true)
            
        }
        else {
            let distanceVC = UIStoryboard.AppStoryboard.Booking.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.Booking.DistancePopOverViewController) as! DistancePopOverViewController
            let img = UIImage(named: UIImage.AppImages.Booking.DeliveryModes.Car)
            distanceVC.image = img
            distanceVC.vehicleName = "Vehicle Car"
            distanceVC.totalDistance = "Total Distance: 124 KM"
            
            self.navigationController?.pushViewController(distanceVC, animated: true)
            
        }
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (self.view.frame.width / 3) - 8, height: self.collectionView.frame.height - 16)
    }
}
