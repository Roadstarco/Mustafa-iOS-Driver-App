//
//  LeftMenuViewController.swift
//  RoadStar Customer
//
//  Created by Roamer on 13/07/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import UIKit
import SDWebImage

class LeftMenuViewController: BaseViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblName: UILabel!
    
    // MARK: Variables And Outlets

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var btnProfile: UIButton!
    
    
    override func setupUI() {
             //Configured with bitbucket repo
        let firstName = UserSession.shared.user?.firstName ?? ""
        let secondName = UserSession.shared.user?.lastName ?? ""
        lblName.text = "\(firstName) \(secondName)"
        lblEmail.text = UserSession.shared.user?.email
        let profileImg = UserSession.shared.user?.avatar ?? ""
        
        if let url = URL(string: profileImg) {
            imgProfile.sd_imageIndicator = SDWebImageActivityIndicator.gray
            imgProfile.sd_setImage(with: url)
        }
        
        // Register all the cells
        self.tableView.register(UINib(nibName: GenericTableViewCell.nibName, bundle: Bundle.main), forCellReuseIdentifier: GenericTableViewCell.cellReuseIdentifier)
        
        self.tableView.reloadData()
    }
    
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    @IBAction func btnProfileTapped(_ sender: Any) {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let profileNav =  storyboard.instantiateViewController(withIdentifier: "ProfileNav") as! UINavigationController
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(profileNav, animated: true, completion: nil)
        
    }
    
    @IBAction func btnProfileImgTapped(_ sender: Any) {
        
    }
    
}

extension LeftMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 45
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: GenericTableViewCell.cellReuseIdentifier) as? GenericTableViewCell else {
            return UITableViewCell()
        }
        
        if indexPath.item == 0 {
            cell.mainLabel.text = Strings.MainMenuNames.home
            cell.mainImageView.image = UIImage(named: UIImage.AppImages.Settings.Home)
        }
        else if indexPath.item == 1 {
            cell.mainLabel.text = Strings.MainMenuNames.postTrip
            cell.mainImageView.image = UIImage(named: UIImage.AppImages.Settings.ManageVehicle)
        }
        else if indexPath.item == 2 {
            cell.mainLabel.text = Strings.MainMenuNames.trackPackage
            cell.mainImageView.image = UIImage(named: "shipping")
        }
        else if indexPath.item == 3 {
            cell.mainLabel.text = Strings.MainMenuNames.documents
            cell.mainImageView.image = UIImage(named: UIImage.AppImages.Settings.Documents)
//            cell.mainImageView.image = UIImage(named: UIImage.AppImages.Settings.History)
        }
        else if indexPath.item == 4 {
            cell.mainLabel.text = Strings.MainMenuNames.history
            cell.mainImageView.image = UIImage(named: UIImage.AppImages.Settings.History)
//            cell.mainImageView.image = UIImage(named: UIImage.AppImages.Settings.Earning)
        }
        else if indexPath.item == 5 {
            cell.mainLabel.text = Strings.MainMenuNames.earning
            cell.mainImageView.image = UIImage(named: UIImage.AppImages.Settings.Earning)
//            cell.mainImageView.image = UIImage(named: UIImage.AppImages.Settings.PaymentMethod)
        }
        else if indexPath.item == 6 {
            cell.mainLabel.text = Strings.MainMenuNames.ContectUs
            cell.mainImageView.image = UIImage(named: UIImage.AppImages.Settings.ContectUs)
        }
        else if indexPath.row == 7{
            cell.mainLabel.text = Strings.MainMenuNames.Message
            cell.mainImageView.image = UIImage(named: UIImage.AppImages.Settings.Message)

        }
        else if indexPath.item == 8 {
            cell.mainLabel.text = Strings.MainMenuNames.Logout
            cell.mainImageView.image = UIImage(named: UIImage.AppImages.Settings.Logout)
        }
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.item == 0 {
            
            let homeNav = UIStoryboard.AppStoryboard.Main.instance.instantiateViewController(withIdentifier: UINavigationController.Identifiers.HomeNav) as! UINavigationController
            
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(homeNav, animated: true, completion: nil)
            
//            setRootViewController(homeNav)
//            self.dismiss(animated: true, completion: nil)
        }
        else if indexPath.item == 1 {
            let vc = UIStoryboard.AppStoryboard.Menu.instance.instantiateViewController(withIdentifier: "PostTripNav") as! UINavigationController
            
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(vc, animated: true, completion: nil)
//            let vc = ProfileVC.instantiateMain()
//            UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(vc, animated: true, completion: nil)
        }
        else if indexPath.item == 2 {
            
            let vc = UIStoryboard.AppStoryboard.Menu.instance.instantiateViewController(withIdentifier: "ScheduledNav") as! UINavigationController
            
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(vc, animated: true, completion: nil)
        }
        else if indexPath.item == 3 {
           
            let vc = UIStoryboard.AppStoryboard.Menu.instance.instantiateViewController(withIdentifier: "DocumentNav") as! UINavigationController
            
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(vc, animated: true, completion: nil)
            
        }
        
        else if indexPath.item == 4 {
            let vc = UIStoryboard.AppStoryboard.Menu.instance.instantiateViewController(withIdentifier: "HistoryNav") as! UINavigationController
            
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(vc, animated: true, completion: nil)
            
        }
        else if indexPath.item == 5 {
            let vc = UIStoryboard.AppStoryboard.Menu.instance.instantiateViewController(withIdentifier: "EarningNav") as! UINavigationController
            
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(vc, animated: true, completion: nil)
            
        }
//        else if indexPath.item == 5 {
//            self.proceedToShareView()
//        }
        else if indexPath.item == 6 {
            let vc = UIStoryboard.AppStoryboard.Menu.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.Menu.SupportViewController) as! UINavigationController
            
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(vc, animated: true, completion: nil)
            
        }else if indexPath.item == 7 {
            
            let vc = UIStoryboard.AppStoryboard.Menu.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.Menu.MessageViewController) as! MessageViewController
            
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(vc, animated: true, completion: nil)
        }
        else if indexPath.item == 8 {
            
            UserSession.shared.logOut()
            let welcomNav = UIStoryboard.AppStoryboard.PreLogIn.instance.instantiateViewController(withIdentifier: UINavigationController.Identifiers.WelcomNav) as! UINavigationController
            UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(welcomNav, animated: true, completion: nil)
        }
    }
    
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        setRootController(controller: vc)
        UIView.transition(with: UIApplication.AppDelegate().window!,
                                 duration: 0.5,
                                 options: .transitionFlipFromLeft,
                                 animations: nil,
                                 completion: nil)
       
    }
    
    func setRootController(controller: UIViewController){
        UIApplication.AppDelegate().setRootController(controller: controller)
    }
    
}
