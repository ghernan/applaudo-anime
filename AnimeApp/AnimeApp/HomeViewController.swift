//
//  ViewController.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/22/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit
import Alamofire
import ObjectMapper

class HomeViewController: UIViewController {
    
    //Private properties
    private let authManager = AuthenticationManager.shared
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadSeriesContent()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        switch authManager.hasAuthToken {
        case true:
            //TODO: reload collection view
            break
        case false:
            authManager.authenticate()
        }
    }
    
    //MARK: - Private functions
    private func loadSeriesContent() {
        
        authManager.tokenCompletionHandler = { hasToken in
            Alamofire.request(AniListSeriesRouter.readSeries()).responseJSON(completionHandler: { (response) in
                if let dictionary = response.value as? [[String : Any]] {
                    let array = Mapper<Series>().mapArray(JSONArray: dictionary)
                    print(array)
                }
            })
        }
        
    }



}

