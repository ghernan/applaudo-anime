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

class AniListManager {
    
    //MARK: Life cycle
    private init() {
    
    }

    //MARK: Static methods
    
    static func getCategories() -> Promise<[Category]> {
        let queue = DispatchQueue.global()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        return firstly {
            AnimeAPIService.sendRequest(fromURLRequest: AniListSeriesRouter.readCategories().urlRequest!)
        
            }.then(on: queue) { json in
                AniListModelParser.parseCategories(fromJSONDictionary: json)
            }.always {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
    }
    
    static func getSeries(withSeriesType type: SeriesType, fromCategory category: Category = Category(), fromSearch query: String = "", inPage page: Int = 1) -> Promise<[Series]> {
        let queue = DispatchQueue.global()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let urlRequest = query != "" ?
            AniListSeriesRouter.browseSeries(withSeriesType: type, withQuery: query) :
            AniListSeriesRouter.readSeries(withSeriesType: type, fromCategoryString: category.genre, inPage: page)
        
        return firstly {
                AnimeAPIService.sendRequest(fromURLRequest: urlRequest.urlRequest!)
            }.then(on: queue) { json in
                AniListModelParser.parseSeriesArray(fromJSONDictionary: json)
            }.always {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            }
    }
    
    static func getDetailedSeries(withID id: Int) -> Promise<Series> {
        let queue = DispatchQueue.global()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        return firstly {
            
            AnimeAPIService.sendRequest(fromURLRequest: AniListSeriesRouter.readSeriesDetail(fromSeriesID: id).urlRequest!)
            
            }.then(on: queue) { json in
                AniListModelParser.parseSeries(fromJSONDictionary: json)
            }.always {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    static func getCurrentUser() -> Promise<User> {
        let queue = DispatchQueue.global()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        return firstly {
            
            AnimeAPIService.sendRequest(fromURLRequest: AniListUserRouter.readUser().urlRequest!)
            
            }.then(on: queue) { json in
                AniListModelParser.parseUser(fromJSONDictionary: json)
            }.always {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
    static func getFavoriteSeries(forUserID id: Int, fromSeriesType type: SeriesType) -> Promise<[Series]> {
        let queue = DispatchQueue.global()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        return firstly {
            
             AnimeAPIService.sendRequest(fromURLRequest: AniListUserRouter.readUserFavorites(fromUserID: id).urlRequest!)
            
            }.then(on: queue) { json in
                AniListModelParser.parseFavoriteSeries(fromJSONDictionary: json, withSeriesType: type)
            }.always {
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
    
}
