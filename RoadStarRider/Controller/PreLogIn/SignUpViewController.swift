//
//  SignUpViewController.swift
//  RoadStar Customer
//
//  Created by Roamer on 04/07/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import UIKit
import FirebaseAuth
import FlagPhoneNumber

class SignUpViewController: BaseViewController  {

    @IBOutlet weak var btnNext: PrimaryButton!
    @IBOutlet weak var phoneTxtField: FPNTextField!
    
    var selectedPhoneNum: String? = nil
    
    override func setupUI() {
        phoneTxtField.delegate = self
        btnNext.isEnabled = selectedPhoneNum != nil
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }

    
    @IBAction func onCLickNextBtn(_ sender: Any) {
        
//        let signUpDetailsVC = UIStoryboard.AppStoryboard.PreLogIn.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.PreLogin.SignupDetailsViewController) as! SignupDetailsViewController
//        signUpDetailsVC.phoneNumber = "+923340117716"
//        self.navigationController?.pushViewController(signUpDetailsVC, animated: true)
//        
//        return
        
//        let vc = UIStoryboard.AppStoryboard.PreLogin.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.PreLogin.VerifyOTPViewController) as! VerifyOTPViewController
//        vc.otpCode = "verificationID"
//        vc.selectedPhoneNumber = "self.selectedPhoneNum!"
//        self.navigationController?.pushViewController(vc, animated: true)
        
      let loader = ProgressIndicator.show(message: "Sending OTP Code...")

        PhoneAuthProvider.provider().verifyPhoneNumber(selectedPhoneNum!, uiDelegate: nil) { (verificationID, error) in
            loader.close()
          if let error = error {
              print(error)
//            Toast.showError(message: error.localizedDescription)
            return
          }
//
            if verificationID != nil{
                let vc = UIStoryboard.AppStoryboard.PreLogIn.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.PreLogin.VerifyOTPViewController) as! VerifyOTPViewController
                vc.verificationId = verificationID
                vc.selectedPhoneNumber = self.selectedPhoneNum!
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
    }
    //Configured with bitbucket repo

    @IBAction func onClickBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}


extension SignUpViewController: FPNTextFieldDelegate{
    
    func fpnDidSelectCountry(name: String, dialCode: String, code: String) {
        dismissKeyboard()
        let listController: FPNCountryListViewController = FPNCountryListViewController(style: .grouped)
        
        phoneTxtField.displayMode = .picker // .picker by default

        listController.setup(repository: phoneTxtField.countryRepository)
        listController.didSelect = { [weak self] country in
            self?.phoneTxtField.setFlag(countryCode: country.code)
            
        }
        let navigationViewController = UINavigationController(rootViewController: listController)
        
        present(navigationViewController, animated: true, completion: nil)

    }
    
    func fpnDidValidatePhoneNumber(textField: FPNTextField, isValid: Bool) {
        
        if isValid {
        let num = textField.getFormattedPhoneNumber(format: .E164)
            selectedPhoneNum = num
            dismissKeyboard()
            print("final selected Phone Number = \(num)")
        } else{
            selectedPhoneNum = nil
        }
        btnNext.isEnabled = selectedPhoneNum != nil
    }
    
    func fpnDisplayCountryList() {
        
        
    }
}



