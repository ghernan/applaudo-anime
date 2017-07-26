//
//  Manga.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/25/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import ObjectMapper

class Manga: Series {
    
    
    
    
    // Mappable
    override func mapping(map: Map) {
        
        id              <- map["id"]
        title           <- map["title_english"]
        imageURL        <- map["image_url_lge"]
        description     <- map["description"]
        chapters        <- map["total_chapters"]
        imageURL        <- map["image_url_lge"]
        startDate       <- (map["start_date_fuzzy"], Date.toDateString)
        endDate         <- (map["end_date_fuzzy"], Date.toDateString)
        characters      <- (map["characters"], SeriesCharacter.transform)
        
    }
}
