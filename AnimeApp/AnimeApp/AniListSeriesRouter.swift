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
    
    case readSeries(fromCategoryString: String)
    
    var query: (path: String, parameters: Parameters) {
        
        switch self {
            
        case .readSeries(let category):
            //print(category)
            return ("browse/anime",["page" : "1",
                                    "sort" : "score-desc", "genres" : category])
        case .readCategories():
            return ("genre_list", [:])
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try AnimeAPI.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(query.path))
        urlRequest.allHTTPHeaderFields = AuthenticationManager.shared.getAuthenticationHeader()
        return try URLEncoding.default.encode(urlRequest, with: query.parameters)
    }
}
