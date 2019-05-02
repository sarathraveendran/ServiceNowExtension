//
//  Enum.swift
//  ServiceNowExtension
//
//  Created by Sarath R on 02/05/19.
//

import Foundation
import UIKit

public enum TicketPriority : Int {
    
    case High = 1, Medium, Low
    var value: String {
        return "\(self.rawValue)"
    }
}
