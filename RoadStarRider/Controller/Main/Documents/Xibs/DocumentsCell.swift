//
//  DocumentsCell.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/6/8.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import UIKit
import SDWebImage

class DocumentsCell: UITableViewCell {

    @IBOutlet weak var vwMain: UIView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    
    
    func setUp(title: String, imgUrl: String, img: UIImage) {
        
        vwMain.layer.cornerRadius = 12
        
        lblTitle.text = title
//        imgView.image = img
        let theUrl = "https://myroadstar.org/storage/app/public/\(imgUrl)"
        if let url = URL(string: theUrl) {
            imgView.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgView.sd_setImage(with: url)
        }
    }
    
}
