//
//  String+toDateString.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/24/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import ObjectMapper

extension String {
    
    static func formatDateString(fuzzyDate: String) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        guard let date = formatter.date(from: fuzzyDate) else {
            return ""
        }
        formatter.dateFormat = "dd MM yyyy"
        
        return formatter.string(from: date)
        
    }
    
    static let toDateString = TransformOf<String, String>(fromJSON: { (dateString: String?) -> String? in
        return dateString != nil ? String.formatDateString(fuzzyDate: dateString!) : nil
        
    }, toJSON: { (fuzzyDate: String?) -> String? in
        
        return fuzzyDate != nil ? fuzzyDate : nil
    })
}

