//
//  AniListUserRouter.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/25/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import Alamofire

enum AniListUserRouter: URLRequestConvertible {
    
    case readUser()
    
    case readUserFavorites(fromUserID: Int)
    
    var query: (path: String, parameters: Parameters) {
        
        switch self {
            
        case .readUser():
            //print(category)
            return ("user", [:])
        case .readUserFavorites(let id):
            return ("user/\(id)/favourites", [:])
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try AnimeAPI.baseURL.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(query.path))
        urlRequest.allHTTPHeaderFields = AuthenticationManager.shared.getAuthenticationHeader()
        return try URLEncoding.default.encode(urlRequest, with: query.parameters)
    }
}
