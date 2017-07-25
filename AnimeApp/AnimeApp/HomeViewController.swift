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
    
    //IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
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

//MARK: - UITableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.reusableIdentifier) as! CategoryCell
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 5
    }
    

}

//MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return "Most popular"
    }
    
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let view = UIView()
//        let label = UILabel()
//        view.backgroundColor = .black
//        label.text = "Most Popular"
//        label.backgroundColor = .clear
//        label.tintColor = .white
//        view.addSubview(label)
//        tableView.headerView(forSection: section)?.contentView.addSubview(view)
//        return view
//        
//    }
}

