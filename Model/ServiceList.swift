//
//  ServiceList.swift
//  ServiceNowExtension
//
//  Created by Elezabeth on 25/04/19.
//

import Foundation

struct ServiceList : Decodable{
    
    var result : [Result]?
    
}

struct Result : Decodable { 
    
    var sys_created_by : String?
    var state : String?
    var short_description : String?
    var sys_class_name : String?
    var sys_id : String?
    
}




struct IncidentReport : Decodable {
    
    var result : Result?
}
