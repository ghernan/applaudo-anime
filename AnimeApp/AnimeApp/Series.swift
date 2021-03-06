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
    var seriesType = ""
    var startDate = ""
    var endDate = "On Going"
    var youTubeID = ""
    var characters: [SeriesCharacter] = []
    var episodes = 0
    var chapters = 0
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        
        id              <- map["id"]
        title           <- map["title_english"]
        imageURL        <- map["image_url_lge"]
        description     <- map["description"]
        episodes        <- map["total_episodes"]
        seriesType      <- map["series_type"]
        imageURL        <- map["image_url_lge"]
        chapters        <- map["total_chapters"]
        startDate       <- (map["start_date_fuzzy"], Date.toDateString)
        endDate         <- (map["end_date_fuzzy"], Date.toDateString)
        characters      <- (map["characters"], SeriesCharacter.transform)
        youTubeID       <- map["youtube_id"]
    }
}

