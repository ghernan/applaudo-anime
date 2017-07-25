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
    var episodes = 0
    var startDate = ""
    var endDate = ""
    var characters: [SeriesCharacter] = []
    
    
    // Mappable
    override func mapping(map: Map) {        
        
        id              <- map["id"]
        title           <- map["title_english"]
        imageURL        <- map["image_url_lge"]
        description     <- map["description"]        
        episodes        <- map["total_episodes"]
        imageURL        <- map["image_url_lge"]
        startDate       <- (map["start_date_fuzzy"], Date.toDateString)
        endDate         <- (map["end_date_fuzzy"], Date.toDateString)
        characters      <- (map["characters"], SeriesCharacter.transform)
        
    }
}
