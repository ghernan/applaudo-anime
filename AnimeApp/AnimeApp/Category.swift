//
//  Category.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/24/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import ObjectMapper

class Category: Mappable {
    
    var id = 0
    var genre = ""
    
    init() {
    
    }
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        id          <- map["id"]
        genre       <- map["genre"]
    }

}
