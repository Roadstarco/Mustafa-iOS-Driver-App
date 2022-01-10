//
//  DocumentsVC.swift
//  RoadStarRider
//
//  Created by Faizan Ali  on 2021/6/8.
//  Copyright © 2021 Faizan Ali . All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
import SDWebImage

class DocumentsVC: BaseViewController, Storyboarded {
    
    @IBOutlet weak var lblDocumentsNotAvailable: UILabel!
    @IBOutlet weak var theTableView: UITableView!
    
    var documents: [DocumentsResponse] = [DocumentsResponse]()
    
    override func setupUI() {

        self.lblDocumentsNotAvailable.isHidden = true
        registerXibs()
        self.getDocuments()
    }
    
    func registerXibs() {
        
        let nib = UINib.init(nibName: "DocumentsCell", bundle: nil)
        theTableView.register(nib, forCellReuseIdentifier: "DocumentsCell")
    }
    
    func getDocuments() {
        
        let pi = ProgressIndicator.show(message: "loading...")
        self.getDocuments { (msg, success) in
                Run.onMain {
                    pi.close()
                    self.theTableView.reloadData()
                    if self.documents.count == 0 {
                        self.lblDocumentsNotAvailable.isHidden = false
                    }
                }
        }
    }
    
    @IBAction func btnGotoDocument(_ sender: Any) {
        let vc = UIStoryboard.AppStoryboard.PreLogIn.instance.instantiateViewController(withIdentifier: UIViewController.Identifiers.PreLogin.UploadDocumentsViewController) as! UploadDocumentsViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
}

import Alamofire

extension DocumentsVC {
    
    func getDocuments(block: @escaping (String?, Bool)-> Void){
        
        let header: HTTPHeaders =
            [
                "Content-Type": "application/json",
                "Accept": "application/json",
                "X-Requested-With": "XMLHttpRequest",
                "Authorization": "Bearer \(UserSession.shared.user?.accessToken ?? "")",
            ]
        
        let url = "https://myroadstar.org/api/provider/documents/display-provider-documents"
        AF.request(url, method: .get, parameters: [:], encoding: URLEncoding.default, headers: header).responseJSON { (response) in
                switch response.result {
                case let .success(value):
                    if let valueData = value as? [[String:Any]] {
                        
                        var allDocuments: [DocumentsResponse] = [DocumentsResponse]()
                        valueData.forEach { (dics) in
                            
                            let data = DocumentsResponse(id: dics["id"] as? Int, providerID: dics["provider_id"] as? Int, documentID: dics["document_id"] as? String, documentName: dics["document_name"] as? String, url: dics["url"] as? String, status: dics["status"] as? String, createdAt: dics["createdAt"] as? String, updatedAt: dics["updatedAt"] as? String)
                            allDocuments.append(data)
                            
                        }
                        
                        
                        self.documents = allDocuments
                        
                        block(nil, true)
                    }else{
                        block(nil, false)
                    }
                case let .failure(error):
                    block(error.localizedDescription, false)
            }
        }
    }
    
}


extension DocumentsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return documents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentsCell") as! DocumentsCell
        
        let name = documents[indexPath.row].documentName ?? ""
        let url = documents[indexPath.row].url ?? ""
        
        var img = UIImage.init(named: "img1")
        if indexPath.row == 1 {
            img = UIImage.init(named: "img2")
        } else if indexPath.row == 2 {
            img = UIImage.init(named: "img3")
        }
        
        cell.setUp(title: name, imgUrl: url, img: img!)
        
        return cell
        
    }
    
    
    
}
