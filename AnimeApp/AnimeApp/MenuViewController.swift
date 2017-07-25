//
//  MenuViewController.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/25/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

class MenuViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.tableFooterView = UIView()

    }


    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
      
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
   
        return 3
    }
    // MARK: - Table view delegate
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewController:HomeViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "homeView") as? HomeViewController else {
            return
        }
        
        switch indexPath.row {
            
        case 0:
            viewController.seriesType = .anime
            show(viewController, sender: self)
        case 1:
            viewController.seriesType = .manga
            show(viewController, sender: self)
        default:
            break
        }        
    }
}
