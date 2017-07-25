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
    
    //Private properties
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
            //TODO: reload collection view
            break
        case false:
            authManager.authenticate()
        }
    }
    
    //MARK: - Private functions
    private func loadSeriesContent() {
        
        authManager.tokenCompletionHandler = { hasToken in

            firstly {
                AniListService.getCategories()
                }.then { categories in
                    self.categories = categories
                }.then { categories in
                    self.tableView.reloadData()
                }.catch{ error in
                    UIAlertController(title: "", message: "", preferredStyle: .alert).show(self, sender: nil)
            }
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
        cell.setCategory(withCategory: categories[indexPath.section])
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



