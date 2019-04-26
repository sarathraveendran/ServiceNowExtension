//
//  DataManager.swift
//  ServiceNowExtension
//
//  Created by Elezabeth on 25/04/19.
//

import Foundation

class DataManager : NSObject{
    
    // Declarations
    static let shared = DataManager()
    
    
    let messages = Messages()
    let keys = GetPostKeys()
    let request = NetworkRequest.shared
    
    
    // MARK: Life Cycle
    private override init() {
        super.init()
        
    }
}




extension DataManager{
    
    func sendIncidentDetails(_ params : Parameters, _ completion : @escaping(_ status: Bool, _ statusMessage: String, _ response: IncidentReport?) -> ()){
        
        let headers = SNManager.shared?.getAuthHeader() ?? HTTPHeaders()
        
        request.post(url: APIEndPoint().incidentReportUrl, params: params, headers: headers) { (networkStatus, response, responseCode) in
            
            // Network Connectivity
            if !networkStatus {
                
                completion(false, self.messages.noConnection, nil)
                return
            }
            // Data validation
            if let incidentDetails: IncidentReport = Parser.parse(response) {
                
                completion(true, "success" , incidentDetails)
                return
            }
            
            // Server Error/ Parsing Error Cases
            completion(false, self.messages.serverNotResponding, nil)
            
        }
    }
    
    
    
    
    func sendIncidentImage(_ params: Parameters, file : Data?, completion : @escaping(_ status: Bool, _ statusMessage: String, _ response: IncidentReport?) -> ()){
        
        // Prepare Headers
        let headers = SNManager.shared?.getAuthHeader() ?? HTTPHeaders()
        
        // Prepare Request
        request.multiPartPost(url: APIEndPoint().uploadImageofIncident, params: params, headers: headers, file: file!, fileKey: "RequestPayload", completionHandler: { (networkStatus, response) in
            
            // Network Connectivity
            if !networkStatus {
                
                completion(false, self.messages.noConnection, nil)
                return
            }
            
            // Data validation
            if let response: IncidentReport = Parser.parse(response) {
                
                completion(true, self.messages.uploadSucess, response)
                
                return
            }
            
            // Server Error/ Parsing Error Cases
            completion(false, self.messages.serverNotResponding, nil)
        })
    }
}
