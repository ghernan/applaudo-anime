//
//  AniListService.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/24/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import PromiseKit
import Alamofire
import ObjectMapper

class AniListService {
    
    //MARK: Life cycle
    private init() {
    
    }

    //MARK: Static methods
    
    static func getCategories() -> Promise<[Category]> {
        let queue = DispatchQueue.global()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        return firstly{
            
            Alamofire.request(AniListSeriesRouter.readCategories()).responseJSON()
        
            }.then(on: queue) { json in
                AniListModelParser.parseCategories(fromJSONDictionary: json)
            }.always {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
    }
    
    static func getSeries(fromCategory category: Category) -> Promise<[Series]> {
        let queue = DispatchQueue.global()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        return firstly{
            
            Alamofire.request(AniListSeriesRouter.readSeries(fromCategoryString: category.genre)).responseJSON()
            
            }.then(on: queue) { json in
                AniListModelParser.parseSeries(fromJSONDictionary: json)
            }.always {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
    }
    
    
}
