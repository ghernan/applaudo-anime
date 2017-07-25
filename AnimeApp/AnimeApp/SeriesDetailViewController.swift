//
//  SeriesDetailViewController.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/25/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

class SeriesDetailViewController: UIViewController {

    //IBOutlets
    
    @IBOutlet weak var seriesImage: UIImageView!
    
    @IBOutlet weak var episodesLabel: UILabel!
    
    @IBOutlet weak var startDateLabel: UILabel!
    
    
    @IBOutlet weak var endDateLabel: UILabel!
    
    
    @IBOutlet weak var studioLabel: UILabel!
    
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    
    
    
    
    
    
    //MARK: - Public properties
    var seriesId = 0
    
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    //MARK: - Private functions
    
    private func loadSeriesInfo() {
    
    }
}
