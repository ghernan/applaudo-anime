//
//  AuthenticationManager.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/23/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import OAuthSwift
import Alamofire

class AuthenticationManager {
    
    //MARK: Singleton property
    static let shared = AuthenticationManager()
    private init() {
        
    }
    
    //MARK: - Private properties
    private let oauthswift = OAuth2Swift(
        consumerKey:    AnimeAPI.clientID,
        consumerSecret: AnimeAPI.clientSecret,
        authorizeUrl:   AniListAuthenticationURL.authorizationCodeURL.urlString,
        accessTokenUrl: AniListAuthenticationURL.accessTokenURL.urlString,
        responseType:   "code"
    )
    
    private var token = "" {
        didSet {
            
            tokenCompletionHandler!(true)
        }
    }
    
    //MARK: - Public properties
    var hasAuthToken = false
    var tokenCompletionHandler:((Bool) -> Void)?
    
    
    //MARK: - Public methods
    
    public func authenticate() {
        
        oauthswift.authorizeURLHandler = WebViewController()
        hasAuthToken = true
        oauthswift.authorize(withCallbackURL: URL(string: AniListAuthenticationURL.redirectURL.urlString)!,
                             scope: "",
                             state: "GET",
                             success: { (credentials, response, parameters) in
                                self.token = credentials.oauthToken
                                print(self.token)
        },
                             failure: {error in
                                print("error: \(error)")
        })
    }
    
    public func getAuthenticationHeader() -> HTTPHeaders {
        
        return [
            "Authorization": "Bearer \(token)",
            "Content-Type": "application/x-www-form-urlencoded"
        ]
    }
}


