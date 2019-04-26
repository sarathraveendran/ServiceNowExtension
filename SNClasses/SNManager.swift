//
//  SNManager.swift
//  ServiceNowExtension
//
//  Created by Elezabeth on 25/04/19.
//

import Foundation


public class SNManager: NSObject {
    
    // Declarations
    let domain: String!
    let userName: String!
    let password: String!
    let keys = GetPostKeys()
    
    static var shared: SNManager?
    
    
    // MARK: Life Cycle
    public init(_ domain: String, userName: String, password: String) {
        
        self.domain = domain
        self.userName = userName
        self.password = password
        super.init()
        
        SNManager.shared = self
    }
    
    
    
    public  func createIncidentTicket(_ subject: String, priority: String, description: String, image: UIImage?, completionHandler: @escaping (_ status: Bool, _ message: String) -> ()) {
        
        // Preare Params
        let subject = subject
        var comments = ""
        comments += "\(priority) priority \n"
        comments += description
        let params: Parameters = [keys.short_description: subject, keys.comments: comments]
        
        // Preapre Request
        DataManager.shared.sendIncidentDetails(params) { (status, message, incidentDetails) in
            
            if !status {
                
                completionHandler(status, message)
                return
            } else {
                
                
                // Validation - Image Existence
                if let image = image {
                    
                    let tableId = incidentDetails?.result?.sys_id ?? ""
                    let tableName = incidentDetails?.result?.sys_class_name ?? ""
                    self.sendImageIncident(tableName, tableId: tableId, image: image, completionHandler: completionHandler)
                    return
                } else {
                    
                    completionHandler(status, message)
                    return
                }
            }
        }
    }
    
    
    func sendImageIncident(_ tableName: String, tableId: String, image: UIImage, completionHandler: @escaping (_ status: Bool, _ message: String) -> () ){
        
        // Prepare Params
        let params : Parameters = [keys.table_name : tableName, keys.table_sys_id : tableId]
        let file = image.jpegData(compressionQuality: 0.4)
        
        // Preapre Request
        DataManager.shared.sendIncidentImage(params, file: file!, completion: { (status, message, incidentDetails) in
            
            completionHandler(status, message)
        })
    }
    
    
    
    func getAuthHeader() -> [String: String]{
        
        // Assign
        let userName = self.userName
        let password = self.password
        
        // Preapre
        let credentials = "\(userName!):\(password!)".data(using: String.Encoding.utf8)
        let basicAuthCredential = credentials?.base64EncodedString() ?? ""
        let headers = ["Authorization": "Basic \(basicAuthCredential)"]
        return headers
    }
}


