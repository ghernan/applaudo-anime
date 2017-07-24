//
//  Anime.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/24/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import ObjectMapper

class Anime: Series {
    
    var description = ""
    var imageURL = ""
    var episodes = ""
    var startDate = ""
    var endDate = ""
    
    
    // Mappable
    override func mapping(map: Map) {
        
        id              <- map["id"]
        title           <- map["title_english"]
        description     <- map["description"]
        imageURL        <- map["image_url_lge"]
        episodes        <- map["total_episodes"]
        startDate       <- (map["start_date_fuzzy"], String.toDateString)
        endDate         <- (map["end_date_fuzzy"], String.toDateString)
        
    }
}