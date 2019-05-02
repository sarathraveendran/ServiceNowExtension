//
//  APIConnection.swift
//  ServiceNowExtension
//
//  Created by Elezabeth on 25/04/19.
//

import Foundation

struct APIEndPoint{
    
    let incidentReportUrl = "/api/now/v1/table/incident"
    let uploadImageofIncident = "/api/now/attachment/upload"
}


struct GetPostKeys {
    
    // Send incident
    let category = "category"
    let short_description = "short_description"
    let priority = "priority"
    let comments = "comments"
    let impact = "impact"
    let urgency = "urgency"
    
    
    //Upload incident Image
    let table_name = "table_name"
    let table_sys_id = "table_sys_id"
    let RequestPayload = "RequestPayload"
}
