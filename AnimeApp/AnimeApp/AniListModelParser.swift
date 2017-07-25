//
//  AniListModelParser.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/25/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import PromiseKit
import ObjectMapper

class AniListModelParser {
    
    static func parseCategories(fromJSONDictionary json: Any) -> Promise<[Category]> {
        
        return Promise { fulfill, reject in
            guard let jsonDictionary = json as? [[String : Any]] else {
                let error = NSError(domain: "AnimeApp", code: 0,
                                    userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
                return reject(error)
            }
            
            fulfill(Mapper<Category>().mapArray(JSONArray: jsonDictionary))
        }
    }
    
    static func parseSeries(fromJSONDictionary json: Any) -> Promise<[Series]> {
        
        return Promise { fulfill, reject in
            guard let jsonDictionary = json as? [[String : Any]] else {
                let error = NSError(domain: "AnimeApp", code: 0,
                                    userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
                return reject(error)
            }
            
            fulfill(Mapper<Series>().mapArray(JSONArray: jsonDictionary))
        }
    }
    
    static func parseAnime(fromJSONDictionary json: Any) -> Promise<Anime> {
        
        return Promise { fulfill, reject in
            guard let jsonDictionary = json as? [String : Any] else {
                let error = NSError(domain: "AnimeApp", code: 0,
                                    userInfo: [NSLocalizedDescriptionKey: "Unknown error"])
                return reject(error)
            }
            
            fulfill(Mapper<Anime>().map(JSON: jsonDictionary)!)
        }
    }


    
}
