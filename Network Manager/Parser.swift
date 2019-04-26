//
//  Parser.swift
//  ServiceNowExtension
//
//  Created by Elezabeth on 25/04/19.
//

import Foundation

struct Parser {
    
    static func parse<T: Decodable>(_ data: Data?) -> T? {
        
        // Validation
        guard let _data = data else {
            
            if logActivity { print(Messages().emptyData) }
            return nil
        }
        
        
        // Parsing
        do {
            
            let modal = try JSONDecoder().decode(T.self, from: _data)
            return modal
        } catch {
            
            print(error)
            return nil
        }
}

}
