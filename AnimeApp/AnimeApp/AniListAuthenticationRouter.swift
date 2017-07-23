//
//  AniListAuthenticationRouter.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/23/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

import Alamofire

enum AniListAuthenticationRouter: URLRequestConvertible {
    
    private static let clientID = "toniohdez-tadmp"
    private static let clientSecret = "nV858UQZpLgvnTuuMFx9K"
    
    case getAuthorizationCode()
    
    case getAccessToken(authorizationCode: String)
    
    case refreshAccessToken(refreshToken: String)
    
    
    
    var query: (path: String, parameters: Parameters) {
        
        switch self {
            
        case .getAuthorizationCode():
            return ("auth/authorize",["grant_type" : "authorization_code", "client_id" : AniListAuthenticationRouter.clientID, "redirect_uri" : "AnimeApp://", "response_type" : "code" ])
            
        case .getAccessToken(let code):
            return ("auth/access_token",["grant_type" : "authorization_code", "client_id" : AniListAuthenticationRouter.clientID, "client_secret" : AniListAuthenticationRouter.clientSecret, "redirect_uri" : "AnimeApp://", "code" : code ])
            
        case .refreshAccessToken(let token):
            return ("auth/access_token",["grant_type" : "refresh_token", "client_id" : AniListAuthenticationRouter.clientID, "client_secret" : AniListAuthenticationRouter.clientSecret, "refresh_token" : token ])            
        }
    }
    
    
    func asURLRequest() throws -> URLRequest {
        
        let url = try AnimeAPI.baseURL.asURL()
        let urlRequest = URLRequest(url: url.appendingPathComponent(query.path))
        return try URLEncoding.default.encode(urlRequest, with: query.parameters)
    }
}
