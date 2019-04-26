//
//  NetworkRequest.swift
//  ServiceNowExtension
//
//  Created by Elezabeth on 25/04/19.
//

import Foundation
import Alamofire

class NetworkRequest: NSObject {
    
    
    // Declarations
    static let shared = NetworkRequest()
    let network = Reachability()
    let endPoint = APIEndPoint()
    
    
    
    // MARK: Life cycle
    private override init() {
        super.init()
    }
    
    
    
    // GET
    func get(url: String, params: [String: Any], headers: HTTPHeaders, encoding: ParameterEncoding = kUrlEncodingByQuesyString, completionHandler: @escaping (_ networkStatus: Bool, _ response: Data?, _ responseCode: Int?) -> ()) {
        
        // Validate Internet Connection
        if !network.isConnected()  {
            
            completionHandler(false, nil, nil)
            return
        }
        
        
        // Send Request
        Alamofire.request(makeUrl(url: url), method: .get, parameters: params, encoding: encoding, headers: headers).validate().responseJSON { response in
            
            // Log
            if logActivity {
                
                print("\n\(String(describing: response.request?.url))")
                if let params = response.request?.httpBody {
                    
                    print("\n\n\(String(data: params, encoding: String.Encoding.utf8) ?? "")")
                }
            }
            
            // Validate Response
            switch response.result {
                
            case .success:
                if logActivity {
                    
                    print(String(data: response.data!, encoding: String.Encoding.utf8) ?? "Nothing")
                }
                completionHandler(true, response.data, response.response?.statusCode)
                
                
            case .failure(let error):
                
                if logActivity {
                    
                    print(response.request ?? "Nothing")  // original URL request
                    print(response.response ?? "Nothing") // HTTP URL response
                    print(String(data: response.data!, encoding: String.Encoding.utf8) ?? "Nothing")     // server data
                    print(response.result)   // result of response serialization
                    print(error)
                }
                
                completionHandler(true, nil, nil)
                return
            }
            
        }
        
    }
    
    
    
    func multiPartPost(url: String, params: Parameters, headers: HTTPHeaders, file: Data, fileKey: String, completionHandler: @escaping (_ networkStatus: Bool, _ response: Data?) -> ())
    {
        
        let myUrl = NSURL(string: makeUrl(url: url));
        let request = NSMutableURLRequest(url:myUrl! as URL);
        request.httpMethod = "POST";
        
        
        let boundary = generateBoundaryString()
        
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        
        let imageData = file
        
        if imageData.isEmpty{
            return
        }
        
        
        request.httpBody = createBody(parameters: params,
                                      boundary: boundary,
                                      data: imageData,
                                      mimeType: "image/jpg",
                                      filename: "ios_\(Int(Date().timeIntervalSince1970*1000)).jpeg")
        
        
        
        
        let task = URLSession.shared.dataTask(with: request as URLRequest) {
            data, response, error in
            
            if error != nil {
                print("error=\(String(describing: error))")
                return
            }
            
            // You can print out response object
            print("******* response = \(String(describing: response))")
            
            // Print out reponse body
            let responseString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print("****** response data = \(responseString!)")
            
            do {
                _ = try JSONSerialization.jsonObject(with: data!, options: []) as? NSDictionary
                
                completionHandler(true, data)
                
                
            }catch
            {
                completionHandler(true, nil)
                return
            }
            
        }
        
        task.resume()
    }
    
    
    func createBody(parameters: [String: String],
                    boundary: String,
                    data: Data,
                    mimeType: String,
                    filename: String) -> Data {
        let body = NSMutableData()
        
        let boundaryPrefix = "--\(boundary)\r\n"
        
        for (key, value) in parameters {
            body.appendString(boundaryPrefix)
            body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
            body.appendString("\(value)\r\n")
        }
        
        body.appendString(boundaryPrefix)
        body.appendString("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimeType)\r\n\r\n")
        body.append(data)
        body.appendString("\r\n")
        body.appendString("--".appending(boundary.appending("--")))
        
        return body as Data
    }
    
    
    func generateBoundaryString() -> String
    {
        return "Boundary-\(NSUUID().uuidString)"
    }
    
    
    // POST
    func post(url: String, params: [String: Any], headers: HTTPHeaders, encoding: ParameterEncoding = kJsonEncoding, completionHandler: @escaping (_ networkStatus: Bool, _ response: Data?, _ responseCode: Int?) -> ()) {
        
        
        // Validate Internet Connection
        if !network.isConnected()  {
            
            completionHandler(false, nil, nil)
            return
        }
        
        
        // Send Request
        Alamofire.request(makeUrl(url: url), method: .post, parameters: params, encoding: encoding, headers: headers).validate().responseJSON { response in
            
            // Log
            if logActivity {
                
                print("\n\(String(describing: response.request?.url))")
                if let params = response.request?.httpBody {
                    
                    print("\n\n\(String(data: params, encoding: String.Encoding.utf8) ?? "")")
                }
            }
            
            // Validate Response
            switch response.result {
                
            case .success:
                if logActivity {
                    
                    print(String(data: response.data!, encoding: String.Encoding.utf8) ?? "Nothing")
                }
                completionHandler(true, response.data, response.response?.statusCode)
                
                
            case .failure(let error):
                
                if logActivity {
                    
                    print(response.request ?? "Nothing")  // original URL request
                    print(response.response ?? "Nothing") // HTTP URL response
                    print(String(data: response.data!, encoding: String.Encoding.utf8) ?? "Nothing")     // server data
                    print(response.result)   // result of response serialization
                    print(error)
                }
                
                completionHandler(true, nil, nil)
                return
            }
        }
    }
    
    
    
    
    // crate url to network call
    func makeUrl(url: String) -> String {
        
        // Validation
        guard let baseUrl = SNManager.shared?.domain else {
         
            return ""
        }
        
        return  baseUrl + url
    }
    
    
    static func getImageUrl(_ url: String) -> String {
        
        // Validation
        guard let baseUrl = SNManager.shared?.domain else {
            
            return ""
        }
        
        return baseUrl + url
    }
}


extension NSMutableData {
  
    func appendString(_ string: String) {
    
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}
