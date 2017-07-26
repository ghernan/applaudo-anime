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
    fileprivate var series: [Series] = []
    fileprivate var seriesType: SeriesType = .anime
    fileprivate var selectedSeriesId = 0 {
        didSet {
            performSegue(withIdentifier: "searchToDetailView", sender: self)
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        configureSearchBar()
        configureActivityIndicator()
        configuringTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        searchController.isActive = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SeriesDetailViewController {
            destination.seriesId = selectedSeriesId
        }
        dismiss(animated: true, completion: nil)
        
    }
    
    //MARK: - Public Methods
    
    
    //MARK: - Private Methods
    private func configureSearchBar() {
        
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
        searchController.searchBar.delegate  = self
        searchController.searchBar.tintColor = .white
        searchController.searchBar.barTintColor = .black
        searchController.searchBar.scopeButtonTitles = [SeriesType.anime.urlParamString(), SeriesType.manga.urlParamString()]
        
    }
    
    @objc private func dismissKeyboard() {
        
        searchController.searchBar.resignFirstResponder()
        searchController.view.endEditing(true)
    }
    
    private func configureActivityIndicator() {
        
        activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .white)
        activityIndicator.frame = CGRect(x:0, y:0, width: 80, height:80)
        activityIndicator.center = tableView.center
        tableView.addSubview(activityIndicator)
        
    }
    
    private func configuringTableView() {
        tableView.tableFooterView = UIView()
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tap.cancelsTouchesInView = false
        tableView.isUserInteractionEnabled = true
        tableView.addGestureRecognizer(tap)
    }
    
    @objc fileprivate func retrieveSeries() {
        activityIndicator.startAnimating()
        if let query = searchController.searchBar.text {
            
            AniListManager.getSeries(withSeriesType: seriesType, fromSearch: query)
                .then { series in
                    self.series = series
                }.then { series in
                    self.tableView.reloadData()
                }.catch { error in
                    UIAlertController(title: "", message: "ERROR: \(error)", preferredStyle: .alert).show(self, sender: nil)
                }.always {
                    self.activityIndicator.stopAnimating()
                }
        }
        
    }
    

}
//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate{
    
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {       
        
        self.dismiss(animated: true, completion: nil)
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(retrieveSeries), object: nil)
       self.perform(#selector(retrieveSeries), with: nil, afterDelay: 1.5)
    }
    
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        seriesType = SeriesType(rawValue: selectedScope)!
        retrieveSeries()
    }
    
}

//MARK: - UITableViewDelegate

extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height
    }
}

//MARK: - UITableViewDataSource

extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.reusableIdentifier)! as! CategoryCell
        
        cell.setSeries(withSeriesList: series)
        cell.setHeight(height: UIScreen.main.bounds.height/5)
        cell.selectedSeries = { id in
            self.selectedSeriesId = id
        }
        return cell
    }
    
}
