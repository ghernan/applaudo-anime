//
//  SearchViewController.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/25/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    
    //MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    //MARK - Private attributes
    private let searchController = UISearchController(searchResultsController: nil)
    private var activityIndicator: UIActivityIndicatorView!

    
    
    
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        configuringTableView()
    }
    
    //MARK: - Public Methods
    
    
    //MARK: - Private Methods
    private func configureSearchBar(){
        
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        
        tableView.tableHeaderView = searchController.searchBar
        
        searchController.searchBar.delegate  = self
        
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .black
        
    }
    
    private func configureActivityIndicator(){
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator.frame = CGRect(x:0, y:0, width: 80, height:80)
        activityIndicator.center = CGPoint(x: self.view.bounds.size.width/2, y: self.view.bounds.size.height/2)
        tableView.addSubview(activityIndicator)
        
    }
    
    private func configuringTableView() {        tableView.tableFooterView = UIView()
        
    }
    

}
//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate{
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {       
        
        self.dismiss(animated: true, completion: nil)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
//        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(), object: nil)
//        self.perform(#selector(), with: nil, afterDelay: 1.5)
    }
    
}

extension SearchViewController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.reusableIdentifier)! as! CategoryCell
        let index = indexPath.row
        
        return cell
    }
    
}
