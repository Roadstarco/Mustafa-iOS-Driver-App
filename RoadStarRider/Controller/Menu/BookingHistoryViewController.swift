//
//  BookingHistoryViewController.swift
//  RoadStar Customer
//
//  Created by Roamer on 21/07/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import UIKit

class BookingHistoryViewController: BaseViewController, UITableViewDelegate, UITableViewDataSource {
    
    

    @IBOutlet weak var theTableView: UITableView!
    
    override func setupUI() {
        registerXib()
    }
    
    override func setupTheme() {
        super.setupTheme()
    }
    
    func registerXib() {
        
        let nib = UINib.init(nibName: BookingHistoryTableViewCell.nibName, bundle: nil)
        theTableView.register(nib, forCellReuseIdentifier: BookingHistoryTableViewCell.cellReuseIdentifier)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: BookingHistoryTableViewCell.cellReuseIdentifier, for: indexPath) as! BookingHistoryTableViewCell
        
        return cell
    }

    
}

