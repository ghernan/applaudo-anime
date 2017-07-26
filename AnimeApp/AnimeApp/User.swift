//
//  User.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/25/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import ObjectMapper

class User: Mappable {
    
    var id = 0
    var userName = ""
    var imageURL = ""
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        
        id          <- map["id"]
        userName    <- map["display_name"]
        imageURL    <- map["image_url_lge"]
    }
    
}
