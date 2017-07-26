//
//  AnimeAPIService.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/26/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import  PromiseKit

class AnimeAPIService {

    private init() {
    
    }
    
    static func sendRequest(fromURLRequest request: URLRequest) -> Promise<Any> {
        return Alamofire.request(request).responseJSON()
    }
}
    
    
