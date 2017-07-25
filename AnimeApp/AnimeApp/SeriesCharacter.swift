//
//  SeriesCharacter.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/25/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import ObjectMapper

class SeriesCharacter: Mappable {
    
    var id = 0
    var firstName = ""
    var lastName = ""
    var imageURL = ""
    
    required init?(map: Map) {
        
    }
    
    // Mappable
    func mapping(map: Map) {
        
        id              <- map["id"]
        firstName       <- map["name_first"]
        lastName        <- map["name_last"]
        imageURL        <- map["image_url_lge"]       
    }
}

extension SeriesCharacter {
    
    static let transform = TransformOf<[SeriesCharacter], Any>(fromJSON: { (jsonDictionary: Any?) -> [SeriesCharacter]? in
        
        guard let jsonDictionary = jsonDictionary as? [[String : Any]] else {
            return nil
        }
        return Mapper<SeriesCharacter>().mapArray(JSONArray: jsonDictionary)
        
    }, toJSON: { (characters: [SeriesCharacter]?) -> String? in
        
        return characters != nil ? "" : nil
    })
    
}
