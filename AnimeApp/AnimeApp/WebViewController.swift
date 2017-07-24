//
//  WebViewController.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/23/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

import UIKit
import OAuthSwift

class WebViewController: OAuthWebViewController {
    
    private var targetURL: URL?
    private var webView: UIWebView = UIWebView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        webView.frame = view.bounds
        webView.autoresizingMask = UIViewAutoresizing.flexibleHeight        
        webView.scalesPageToFit = true
        view.addSubview(webView)
        loadAddressURL()
    }
    
    override func handle(_ url: URL) {
        super.handle(url)
        targetURL = url        
        loadAddressURL()
    }
    
    func loadAddressURL() {
        if let targetURL = targetURL {
            let req = URLRequest(url: targetURL)
            webView.loadRequest(req)
        }
    }
}
