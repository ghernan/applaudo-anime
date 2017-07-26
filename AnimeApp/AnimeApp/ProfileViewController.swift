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
    
    @IBOutlet weak var userImage: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    //Public properties
    
    //Private properties
    fileprivate var userId = 0
    fileprivate var animes: [Series] = []
    fileprivate var mangas: [Series] = []
    private let authManager = AuthenticationManager.shared
    
    fileprivate var selectedSeriesId = 0 {
        didSet {
            performSegue(withIdentifier: "profileToSeriesDetail", sender: self)
        }
    }
    
    //MARK: - Life cycle
    override func viewDidLoad() {
        
        super.viewDidLoad()
        customizingComponents()
        retrieveUserInfo()
    }
    
   
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? SeriesDetailViewController {
            destination.seriesId = selectedSeriesId
        }
    }
    
    //MARK: - Private functions
    private  func customizingComponents() {
        tableView.sectionHeaderHeight = 40
        userImage.layer.masksToBounds = true
        userImage.layer.cornerRadius = userImage.frame.height/2
    }
    private func retrieveUserInfo() {
        
        firstly {
            AniListManager.getCurrentUser()
            }.then { user in
                self.setUserInfo(fromUser: user)
            }.then {
                AniListManager.getFavoriteSeries(forUserID: self.userId, fromSeriesType: .anime)
                
            }.then { series in
                self.animes = series
                
            }.then {
                AniListManager.getFavoriteSeries(forUserID: self.userId, fromSeriesType: .manga)
                
            }.then { series in
                self.mangas = series
                
            }.then {
                self.tableView.reloadData()
                
            }.catch { error in
                
                ErrorHelper.throwAlert(withError: error, on: self)
            }
    }
    
    private func setUserInfo(fromUser user: User) {
        nameLabel.text = user.userName
        userId = user.id
        guard let imageUrl = URL(string: user.imageURL) else {
            return
        }
        ImageDownloadHelper.getImage(fromURL: imageUrl)
            .then { image in
                
                self.userImage.image = image
        
            }.catch { error in
                ErrorHelper.throwAlert(withError: error, on: self)
            }   
    }
    private func setFavorites(forSeriesType type: SeriesType, withSeriesList list: [Series]) {
        switch  type {
        case .anime:
            self.animes = list
        case .manga:
            self.mangas = list
        }
    }

    fileprivate func retrieveFavorites(withSeriesType type: SeriesType) {
        AniListManager.getFavoriteSeries(forUserID: userId, fromSeriesType: type)
            .then { series in
                
                self.setFavorites(forSeriesType: type, withSeriesList: series)
                
            }.catch { error in
                print(error)
            }
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
        cell.setSeries(withSeriesList: seriesType == .anime ? animes : mangas)
        cell.setHeight(height: cell.frame.height-10)
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
        label.text = section == 0 ? "Anime ❤️" : "Manga ❤️" 
        view.addSubview(label)
        view.backgroundColor = .black // Set your background color        
        return view
        
    }
}
