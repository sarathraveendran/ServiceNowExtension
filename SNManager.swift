//
//  SNManager.swift
//  ServiceNowExtension
//
//  Created by Elezabeth on 25/04/19.
//

import Foundation


class SNManager: NSObject {
    
   
    let domain: String!
    let userName: String!
    let password: String!
    
    
    // MARK: Life Cycle
    init(_ domain: String, userName: String, password: String) {
        
        self.domain = domain
        self.userName = userName
        self.password = password
        super.init()
    }
    
    
    
    func updateAuthManager() {
        
    }
    
}
