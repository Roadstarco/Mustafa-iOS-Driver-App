 
 
 import Foundation
 import Alamofire
 import SafariServices
 
 enum AppURL:String {
    case registerAsCompany = "https://myroadstar.org/fleet/register"
    
    func open(parent: UIViewController) {
        self.openURL(urlString: self.rawValue, parent: parent)
    }
    
   private func openURL(urlString:String, parent: UIViewController) {
        if let url = URL(string: urlString) {
            let vc: SFSafariViewController
            if #available(iOS 11.0, *) {
                let config = SFSafariViewController.Configuration()
                config.entersReaderIfAvailable = false
                vc = SFSafariViewController(url: url, configuration: config)
            } else {
                vc = SFSafariViewController(url: url, entersReaderIfAvailable: false)
            }
            parent.present(vc, animated: true)
        }
    }
    
 }
//Configured with bitbucket repo

 
 
 protocol URLRequestBuilder: URLRequestConvertible, APIRequestHandler {
    
    var mainURL: URL { get }
    var requestURL: URL { get }
    // MARK: - Path
    var path: String { get }
    
    // MARK: - Parameters
    var parameters: Parameters? { get }
    
    var headers: HTTPHeaders { get }
    
    // MARK: - Methods
    var method: HTTPMethod { get }
    
    var encoding: ParameterEncoding { get }
    
    var urlRequest: URLRequest { get }
 }
 
 
 extension URLRequestBuilder {
    var encoding: ParameterEncoding {
        switch method {
        case .get:
            return URLEncoding.default
        default:
            return JSONEncoding.default
        }
    }
    
    var mainURL: URL  {
        
        return URL(string: "https://myroadstar.org/api/provider/")!
        
    }
    
    var requestURL: URL {
        return mainURL.appendingPathComponent(path)
    }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: requestURL)
        request.httpMethod = method.rawValue
        headers.forEach { (header) in 
            request.addValue(header.value, forHTTPHeaderField: header.name)
        }
        
        return request
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        return try encoding.encode(urlRequest, with: parameters)
    }
 }
