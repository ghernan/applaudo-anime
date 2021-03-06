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
import PromiseKit

class HomeViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var tableView: UITableView!
    //Public properties
    public var seriesType: SeriesType = .anime
    //Private properties
    private var activityIndicator: UIActivityIndicatorView!
    private let authManager = AuthenticationManager.shared
    fileprivate var categories: [Category] = []
    fileprivate var selectedSeriesId = 0 {
        didSet {
            performSegue(withIdentifier: "toSeriesDetail", sender: self)
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        loadSeriesContent()
        tableView.sectionHeaderHeight = 40
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SeriesDetailViewController {
            destination.seriesId = selectedSeriesId
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        
        switch authManager.hasAuthToken {
        case true:
            loadSeriesContent()
            break
        case false:
            authManager.authenticate()
        }
    }
    
    //MARK: - Private functions
    
    private func configureActivityIndicator() {
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.frame = CGRect(x:0, y:0, width: 80, height:80)
        activityIndicator.center = view.center
        view.addSubview(activityIndicator)
        
    }
    
    private func loadSeriesContent() {
        
        
        switch authManager.hasAuthToken {
        case true:
            retrieveSeries()
            break
        case false:
            authManager.tokenCompletionHandler = { hasToken in
                self.retrieveSeries()
            }
        }
    }
       
    private func retrieveSeries() {
        configureActivityIndicator()
        activityIndicator.startAnimating()
        firstly {
            AniListManager.getCategories()
            }.then { categories in
                self.categories = categories
            }.then { categories in
                self.tableView.reloadData()
            }.catch { error in
                ErrorHelper.throwAlert(withError: error, on: self)
            }.always {
                self.activityIndicator.stopAnimating()
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
        cell.setCategory(withSeriesType: seriesType, fromCategory: categories[indexPath.section])
        cell.setHeight(height: cell.frame.height-10)
        cell.selectedSeries = { id in
            self.selectedSeriesId = id
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    

}

//MARK: - UITableViewDelegate

extension HomeViewController: UITableViewDelegate {

    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 18))
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width, height: 18))
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.text = categories[section].genre
        view.addSubview(label)
        view.backgroundColor = .black // Set your background color
        
        return view
        
    }
}



