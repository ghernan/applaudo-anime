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
    var id = 0
    var title = ""
    var imageURL = ""
    var description = ""
    var startDate = ""
    var endDate = ""
    var characters: [SeriesCharacter] = []
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        
        id          <- map["id"]
        title       <- map["title_english"]
        imageURL    <- map["image_url_lge"]
    }
}

