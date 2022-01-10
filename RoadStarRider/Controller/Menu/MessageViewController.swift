//
//  MessageViewController.swift
//  RoadStarRider
//
//  Created by Apple on 23/12/2021.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import Foundation
import UIKit
import FirebaseDatabase
import Firebase
import SDWebImage

class MessageViewController: BaseViewController, Storyboarded {
    
    @IBOutlet weak var theTableView: UITableView!
    @IBOutlet weak var btnBack: UIButton!
    
    
    var ids = [String]()
    var mess = [String:Any]()

    
    override func setupUI() {
        
        self.fetchUser()
        
    }
    
    func fetchUser(){
        
        let use = UserDefaults.standard.string(forKey: "uid")
      
        FirebaseDatabase.Database.database().reference().child("Friends").child(use ?? "").observe(.childAdded) { (snapshot) in
            self.ids.append(snapshot.key)
  
            var dic = [String:Any]()
            for child in snapshot.children {
                let snap = child as! DataSnapshot
                     let key = snap.key
                     let value = snap.value
                dic[snap.key] = snap.value
                     print("key = \(key)  value = \(value!)")
            
            }
            self.mess[snapshot.key]=dic
            
                self.theTableView.reloadData()
                
        }
        
    }
    
    override func setupTheme() {
        super.setupTheme()
    }
    
    @IBAction func btnBackTappe(_ sender: Any) {
        
        self.continueToMain()
    }
    
    func continueToMain() {

        let homeNav = UIStoryboard.AppStoryboard.Main.instance.instantiateViewController(withIdentifier: UINavigationController.Identifiers.HomeNav) as! UINavigationController
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(homeNav, animated: true, completion: nil)
    }
    
}
extension MessageViewController : UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ids.count
    
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
         let cell = tableView.dequeueReusableCell(withIdentifier: "cell2", for: indexPath) as! MessageMemberTableViewCell
        
        let dic = self.mess[ids[indexPath.row]] as! NSDictionary
        print(dic)
        let message = dic["message"] as! NSDictionary
        print(message["text"] as! String)
        cell.nameLabel.text = dic["name"] as? String
        if dic["avata"] != nil{
            let image = dic["avata"] as! String
            cell.memberImage.sd_setImage(with: URL(string: image  ) )
        }
        
//        cell.memberImage.sd_setImage(with: URL(string: dic["avata"] as! String ), placeholderImage: UIImage(named: "userprofile.png"))
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

        let dic = self.mess[ids[indexPath.row]] as! NSDictionary
        let vc = SupportViewController.instantiateMenu()
        vc.user_idString = dic["id"] as! String
        vc.fromMessage = true
        vc.first_name = dic["name"] as! String
        if dic["avata"] != nil{
            let image = dic["avata"] as! String
            vc.picture = image
        }
         
        let navigationCont = UINavigationController(rootViewController: vc)
        navigationCont.navigationController?.setNavigationBarHidden(true, animated: false)
        navigationCont.modalPresentationStyle = .overCurrentContext
        self.present(navigationCont, animated: true, completion: nil)
    }
    
        
}
