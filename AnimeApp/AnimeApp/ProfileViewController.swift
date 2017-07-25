//
//  ProfileViewController.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/25/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

import UIKit
import Alamofire
import ObjectMapper
import PromiseKit

class ProfileViewController: UIViewController {
    
    //IBOutlets
    @IBOutlet weak var tableView: UITableView!
    //Public properties
    
    //Private properties
    fileprivate var animes: [Anime] = []
    //private var mangas: [Manga] = []
    private let authManager = AuthenticationManager.shared
    
    fileprivate var selectedSeriesId = 0 {
        didSet {
            performSegue(withIdentifier: "profileToSeriesDetail", sender: self)
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        tableView.sectionHeaderHeight = 40
        retrieveUserInfo()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SeriesDetailViewController {
            destination.seriesId = selectedSeriesId
        }
    }
    

    
    //MARK: - Private functions

    
    private func retrieveUserInfo() {
        
        
        
    }
}

//MARK: - UITableViewDataSource

extension ProfileViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let seriesType: SeriesType = indexPath.section == 0 ? .anime : .manga
        let cell = tableView.dequeueReusableCell(withIdentifier: CategoryCell.reusableIdentifier) as! CategoryCell
        
        cell.selectedSeries = { id in
            self.selectedSeriesId = id
        }
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
}

//MARK: - UITableViewDelegate

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: 18))
        let label = UILabel(frame: CGRect(x: 10, y: 5, width: tableView.frame.size.width, height: 18))
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .white
        label.text = section == 0 ? "Anime" : "Manga"
        view.addSubview(label)
        view.backgroundColor = .black // Set your background color        
        return view
        
    }
}
