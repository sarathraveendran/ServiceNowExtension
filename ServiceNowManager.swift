//
//  ServiceNowManager.swift
//  Pods-ServiceNowExtension_Example
//
//  Created by Sarath R on 22/04/19.
//

import Foundation
import UIKit

//extension UIImageView {
//   
//    public func circleImageView(borderColor: UIColor, borderWidth: CGFloat){
//        
//        self.layer.borderColor = borderColor.cgColor
//        self.layer.borderWidth = borderWidth
//        self.layer.cornerRadius = self.layer.frame.size.width / 2
//        self.clipsToBounds = true
//    }
//}


public class ServiceNowManager: NSObject {
    
    
    public static let shared = ServiceNowManager()
    
    private override init() {
        super.init()
        
        
    }
    
    
    
    public func getApproval() -> String {
        
        return "Approved"
    }
    
}
