//
//  UploadDocumentsViewController.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/5/10.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import Foundation
import UIKit
import iOSDropDown
import SkyFloatingLabelTextField
import Alamofire
enum UploadDocumentsType {
    case vehicle, licence, licenceRegNo, insurance, residenceProof
}

class UploadDocumentsViewController: BaseViewController {

    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var imgResProof: UIImageView!
    @IBOutlet weak var imgIncurance: UIImageView!
    @IBOutlet weak var imgRegNo: UIImageView!
    @IBOutlet weak var imgLicence: UIImageView!
    @IBOutlet weak var imgVehicle: UIImageView!
    
    var selectedVehicleImage: UIImage? = nil
    var selectedLicenceImage: UIImage? = nil
    var selectedRegNoImage: UIImage? = nil
    var selectedResProofImage: UIImage? = nil
    var selectedInsuranceImage: UIImage? = nil
    var selectedType: UploadDocumentsType = .vehicle
    var documents: [DocumentList] = [DocumentList]()

    
    var imagePicker: ImagePicker!
    var fromSignUP: Bool = false
    
    override func setupUI() {
        
        btnBack.isHidden = fromSignUP
        setupImages()
        self.imagePicker = ImagePicker(presentationController: self, delegate: self)
        self.getDocuments()
    }
    
    override func setupTheme() {
        super.setupTheme()
        
    }
    
    @IBAction func btnBackTapped(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onCLickNextBtn(_ sender: Any) {
        
        uploadDocument { (msg, success) in
            
            
            if self.fromSignUP {
                let homeNav = UIStoryboard.AppStoryboard.Main.instance.instantiateViewController(withIdentifier: UINavigationController.Identifiers.HomeNav) as! UINavigationController
                UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(homeNav, animated: true, completion: nil)
            } else {
                self.navigationController?.popViewController(animated: true)
            }
            
        }
        
        
    }
    @IBAction func btnVehicleImageTapped(_ sender: UIButton) {
        self.selectedType = .vehicle
        self.imagePicker.present(from: sender, showCamera: true, showLibrary: true)
    }
    
    @IBAction func btnLicenceTapped(_ sender: UIButton) {
        self.selectedType = .licence
        self.imagePicker.present(from: sender, showCamera: true, showLibrary: true)
    }
    
    @IBAction func btnLogOutTapped(_ sender: Any) {
        UserSession.shared.logOut()
        let welcomNav = UIStoryboard.AppStoryboard.PreLogIn.instance.instantiateViewController(withIdentifier: UINavigationController.Identifiers.WelcomNav) as! UINavigationController
        UIApplication.shared.windows.filter {$0.isKeyWindow}.first!.replaceRootViewControllerWith(welcomNav, animated: true, completion: nil)
    }
    
    @IBAction func btnLicenceRegNoTapped(_ sender: UIButton) {
        self.selectedType = .licenceRegNo
        self.imagePicker.present(from: sender, showCamera: true, showLibrary: true)
    }
    
    @IBAction func btnInsuranceTapped(_ sender: UIButton) {
        self.selectedType = .insurance
        self.imagePicker.present(from: sender, showCamera: true, showLibrary: true)
    }
    
    @IBAction func btnResProof(_ sender: UIButton) {
        self.selectedType = .residenceProof
        self.imagePicker.present(from: sender, showCamera: true, showLibrary: true)
    }
    
    func setupImages() {
        self.imgVehicle.image = selectedVehicleImage
        self.imgLicence.image = selectedLicenceImage
        self.imgRegNo.image = selectedRegNoImage
//        self.imgResProof.image = selectedResProofImage
        self.imgIncurance.image = selectedInsuranceImage
    }
    
    func getDocuments(){
        
        let header: HTTPHeaders =
            [
                "Content-Type": "application/json",
                "Accept": "application/json",
                "X-Requested-With": "XMLHttpRequest",
                "Authorization": "Bearer \(UserSession.shared.user?.accessToken ?? "")",
            ]
        
        let url = "https://myroadstar.org/api/provider/documents/listing"
        AF.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: header).responseJSON { (response) in
                switch response.result {
                case let .success(value):
                    if let valueData = value as? [[String:Any]] {
                        
                        var allDocuments: [DocumentList] = [DocumentList]()
                        valueData.forEach { (dics) in
                            
                            let data = DocumentList(id: dics["id"] as? Int,
                                                    name: dics["name"] as? String,
                                                    type: dics["type"] as? String)
                            allDocuments.append(data)
                            
                        }
                        
                        
                        self.documents = allDocuments
                        print(self.documents)
                        
                    }else{
                    }
                case let .failure(error):
                    print(error)
            }
        }
    }
}

extension UploadDocumentsViewController: ImagePickerDelegate {
    func didSelect(image: UIImage?) {

        if let img = image {
            
            if self.selectedType == .vehicle {
                self.selectedVehicleImage = img
            } else if self.selectedType == .insurance {
                self.selectedInsuranceImage = img
            } else if self.selectedType == .licence {
                self.selectedLicenceImage = img
            } else if self.selectedType == .licenceRegNo {
                self.selectedRegNoImage = img
            }
//            else if self.selectedType == .residenceProof {
//                self.selectedResProofImage = img
//            }
        }
        setupImages()
    }
    
    func didSelect(videoUrl: NSURL?) {
    }
}



extension UploadDocumentsViewController {
    
    func uploadDocument(block: @escaping (String?, Bool)-> Void){
        
        if selectedVehicleImage == nil {
            Toast.showError(message: "Kindly upload vehicle image")
            return
        } else if selectedInsuranceImage == nil {
            Toast.showError(message: "Kindly upload Insurance image")
            return
        } else if selectedLicenceImage == nil {
            Toast.showError(message: "Kindly upload Licence image")
            return
        } else if selectedRegNoImage == nil {
            Toast.showError(message: "Kindly upload RegNo image")
            return
        }
//        else if selectedResProofImage == nil {
//            Toast.showError(message: "Kindly upload ResProof image")
//            return
//        }
        
        let pi = ProgressIndicator.show(message: "loading...")
        if let img = self.selectedVehicleImage {
            let ud = UploadData(data: img.pngData()!, fileName: "\(Date().timeIntervalSince1970).png", mimeType: "png", name: "picture[]")
            
            self.uploadTheDocument(id: "10", name: "Proof Of Inspection", data: ud) { (msg, success) in
                
                if let img = self.selectedInsuranceImage {
                    let ud = UploadData(data: img.pngData()!, fileName: "\(Date().timeIntervalSince1970).png", mimeType: "png", name: "picture[]")
                    self.uploadTheDocument(id: "4", name: "Certified Copy", data: ud) { (msg, success) in
                        
                        if let img = self.selectedLicenceImage {
                            let ud = UploadData(data: img.pngData()!, fileName: "\(Date().timeIntervalSince1970).png", mimeType: "png", name: "picture[]")
                            self.uploadTheDocument(id: "9", name: "ID", data: ud) { (msg, success) in
                                
                                if let img = self.selectedRegNoImage {
                                    let ud = UploadData(data: img.pngData()!, fileName: "\(Date().timeIntervalSince1970).png", mimeType: "png", name: "picture[]")
                                    self.uploadTheDocument(id: "1", name: "Driving License", data: ud) { (msg, success) in
                                        pi.close()
                                        block(nil, true)
                                        //Configured with bitbucket repo
//                                        if let img = self.selectedResProofImage {
//                                            let ud = UploadData(data: img.pngData()!, fileName: "\(Date().timeIntervalSince1970).png", mimeType: "png", name: "picture[]")
//                                            self.uploadTheDocument(id: "10", name: "Proof Of Inspection", data: ud) { (msg, success) in
//
//                                                pi.close()
//                                                block(nil, true)
//                                            }
//                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func uploadTheDocument(id: String, name: String, data: UploadData, block: @escaping (String?, Bool)-> Void){
        
        
        TheRoute.uploadDocument(documentId: id, documentName: name).send(OnlyMsgResponse.self, data: data, multipleData: nil) { (progress) in
            print(progress)
        } then: { (results) in
            switch results {
            case .failure(let error):
                print(error)
                block(error.localizedDescription, false)
                
                
            case .success( _ ):
                block(nil, true)
            }
        }
    }
    
    
}
