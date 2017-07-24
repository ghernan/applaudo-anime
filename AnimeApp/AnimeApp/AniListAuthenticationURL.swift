//
//  AniListAuthenticationRouter.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/23/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

import Alamofire

enum AniListAuthenticationURL: String {
    
    case authorizationCodeURL
    
    case accessTokenURL
    
    case redirectURL
    
    var urlString: String {
        
        switch self {
            
        case .authorizationCodeURL:
            return "\(AnimeAPI.baseURL)auth/authorize"
            
        case .accessTokenURL:
            return "\(AnimeAPI.baseURL)auth/access_token"
            
        case .redirectURL:
            return "AnimeApp://oauth-callback"
            
        }
    }
}
