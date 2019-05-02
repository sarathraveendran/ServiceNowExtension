//
//  ViewController.swift
//  ServiceNowExtension
//
//  Created by Sarath Raveendran on 04/22/2019.
//  Copyright (c) 2019 Sarath Raveendran. All rights reserved.
//

import UIKit
import ServiceNowExtension



class ViewController: UIViewController {
    
    
    // Declarations
    var snManager: SNManager!
    
    
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        createServiceNowInstance()
    }
    
    
    
    func createServiceNowInstance() {
        
        // Configure Service Now
        let domain   =  "https://netrixllcdemo2.service-now.com"
        let userName =  "sjohn"
        let password =  "Silver1"
        
        snManager = SNManager(domain, userName: userName, password: password)
    }
    
    
    
    func createATicket() {
        
        let subject = "Subject 1"
        let priority = TicketPriority.High
        let description = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book"
        let incidentImage = #imageLiteral(resourceName: "picx")
     
        snManager.createIncidentTicket(subject, priority: priority, description: description, image: incidentImage) { (status, message) in
            
            print(status)
        }
    }
}





extension ViewController {
    
    
    @IBAction func createTicketAction(_ sender: UIButton) {
        
        createATicket()
    }
}
