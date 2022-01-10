//
//  MessageMemberTableViewCell.swift
//  Family Pic Will
//
//  Created by mac on 8/20/21.
//

import UIKit


class MessageMemberTableViewCell: UITableViewCell, UINavigationControllerDelegate {
    

    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var memberImage: UIImageView!
    
     override func awakeFromNib() {
        super.awakeFromNib()
            
          
        }
    
        
        

        override func setSelected(_ selected: Bool, animated: Bool) {
            super.setSelected(selected, animated: animated)
            
            // Configure the view for the selected state
            
    }
    
}
