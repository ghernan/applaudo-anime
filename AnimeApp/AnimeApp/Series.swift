//
//  Anime.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/24/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import ObjectMapper

class Series: Mappable {
    var id = ""
    var title = ""
    var imageURL = ""
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        
        id          <- map["0.id"]
        title       <- map["0.title_english"]
        imageURL    <- map["0.image_url_lge"]        
    }
}

