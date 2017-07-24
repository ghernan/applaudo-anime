//
//  AuthenticationManager.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/23/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import OAuthSwift

class AuthenticationManager {
    
    //MARK: Singleton property
    static let shared = AuthenticationManager()
    private init() {
        
    }
    
    //MARK: - Private properties
    private let oauthswift = OAuth2Swift(
        consumerKey:    AnimeAPI.clientID,
        consumerSecret: AnimeAPI.clientSecret,
        authorizeUrl:   AniListAuthenticationURLs.authorizationCodeURL.urlString,
        accessTokenUrl: AniListAuthenticationURLs.accessTokenURL.urlString,
        responseType:   "code"
    )
    
    private var token = "" {
        didSet {
            hasAuthToken = true
            tokenCompletionHandler!(true)
        }
    }
    
    //MARK: - Public properties
    var hasAuthToken = false
    var tokenCompletionHandler:((Bool) -> Void)?
    
    
    //MARK: - Public methods
    
    public func authenticate() {
        
        oauthswift.authorizeURLHandler = WebViewController()
        oauthswift.authorize(withCallbackURL: URL(string: "AnimeApp://oauth-callback")!,
                             scope: "",
                             state: "GET",
                             success: { (credentials, response, parameters) in
                                self.hasAuthToken = true
                                self.token = credentials.oauthToken
        },
                             failure: {error in
                                print("error: \(error)")
        })
    }
}


