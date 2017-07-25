//
//  AniSeriesRouter.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/24/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import Alamofire

enum AniListSeriesRouter: URLRequestConvertible {
    
    case readCategories()
    
    case readSeries(withSeriesType: SeriesType, fromCategoryString: String)
    
    case readSeriesDetail(fromSeriesID: Int)
    
    var query: (path: String, parameters: Parameters) {
        
        switch self {
            
        case .readSeries(let type, let category):
            //print(category)
            return ("browse/\(type)",["page" : "1",
                                    "sort" : "score-desc", "genres" : category])
        case .readCategories():
            return ("genre_list", [:])
            
        case .readSeriesDetail(let id):
            return ("anime/\(id)/page",[:])
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try AnimeAPI.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(query.path))
        urlRequest.allHTTPHeaderFields = AuthenticationManager.shared.getAuthenticationHeader()
        return try URLEncoding.default.encode(urlRequest, with: query.parameters)
    }
}
