//
//  String+toDateString.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/24/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import ObjectMapper

extension Date {
    
    static func formatDateString(fuzzyDate: Int) -> String {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        guard let date = formatter.date(from: "\(fuzzyDate)") else {
            return ""
        }
        formatter.dateFormat = "dd MMM yyyy"
        
        return formatter.string(from: date)
        
    }
    
    static let toDateString = TransformOf<String, Int>(fromJSON: { (fuzzyDate: Int?) -> String? in
        return fuzzyDate != nil ? Date.formatDateString(fuzzyDate: fuzzyDate!) : nil
        
    }, toJSON: { (fuzzyDate: String?) -> Int? in
        
        return fuzzyDate != nil ? 0 : nil
    })
}

