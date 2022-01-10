//
//  VerifyOTPViewController.swift
//  RoadStar Customer
//
//  Created by Roamer on 14/07/2020.
//  Copyright © 2020 Osama Azmat Khan. All rights reserved.
//

import UIKit
import FirebaseAuth
import KWVerificationCodeView

class VerifyOTPViewController: BaseViewController, KWVerificationCodeViewDelegate {
    
    @IBOutlet weak var lblPhone: UILabel!
    @IBOutlet weak var verificationView: KWVerificationCodeView!
    
    var verificationId: String!
    var selectedPhoneNumber: String!
    
    override func setupUI() {
        lblPhone.text = "at \(selectedPhoneNumber!)"
        verificationView.delegate = self
    }

    @IBAction func onCLickNextBtn(_ sender: Any) {
        
        self.didChangeVerificationCode()
//        let signUpDetailsVC = UIStoryboard.AppStoryboard.PreLogIn.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.PreLogin.SignupDetailsViewController) as! SignupDetailsViewController
//        self.navigationController?.pushViewController(signUpDetailsVC, animated: true)
    }
    
    @IBAction func onClickBackBtn(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    func didChangeVerificationCode() {

        if verificationView.hasValidCode(){
            self.view.endEditing(true)
            
            let code = verificationView.getVerificationCode()
            validateCode(code: code)
            
//            return
            
//            if code == "946446"{
//
//                Toast.show(message: "Phone number has been verified.")
//
//                let signUpDetailsVC = UIStoryboard.AppStoryboard.PreLogIn.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.PreLogin.SignupDetailsViewController) as! SignupDetailsViewController
//                signUpDetailsVC.phoneNumber = self.selectedPhoneNumber
//                self.navigationController?.pushViewController(signUpDetailsVC, animated: true)
//            }
            
            
//            if code == otpCode{
//                let signUpDetailsVC = UIStoryboard.AppStoryboard.PreLogin.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.PreLogin.SignupDetailsViewController) as! RSCSignupDetailsViewController
//                signUpDetailsVC.phoneNumber = selectedPhoneNumber
//                self.navigationController?.pushViewController(signUpDetailsVC, animated: true)
//            } else{
//                verificationView.clear()
//                Toast.show(message: "Code has not matched! Try again.")
//            }
//            print("Yes the code is \(verificationView.getVerificationCode())")
        }
    }
    
    func validateCode(code: String) {
        
        let credential = PhoneAuthProvider.provider().credential(
            withVerificationID: self.verificationId,
        verificationCode: code)
        
        let pi = ProgressIndicator.show(message: "loading...")
        Auth.auth().signIn(with: credential) { (authResult, error) in
        
            pi.close()
            if error != nil {
                Toast.showError(message: "Invalid code")
                return
            }
            //Configured with bitbucket repo

            if authResult?.user.uid != nil{
                Toast.show(message: "Phone number has been verified.")
                try? Auth.auth().signOut()
                let signUpDetailsVC = UIStoryboard.AppStoryboard.PreLogIn.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.PreLogin.SignupDetailsViewController) as! SignupDetailsViewController
                signUpDetailsVC.phoneNumber = self.selectedPhoneNumber
                self.navigationController?.pushViewController(signUpDetailsVC, animated: true)
            } else {
                Toast.showError(message: "Something went wrong!")
            }
        }
    }
}
