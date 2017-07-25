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
    
    @IBOutlet weak var titleLabel: UILabel!
    
    
    @IBOutlet weak var collectionView: UICollectionView!    
    
    
    //MARK: - Public properties
    var seriesId = 0
    
    //MARK: Private properties
    fileprivate var series: Anime!
    fileprivate var seriesCharacters: [SeriesCharacter] = []
    fileprivate var mWidth: CGFloat = 0
    fileprivate var mHeight: CGFloat = 0
    fileprivate var sectionInsets = UIEdgeInsets()
    
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareCollectionView()
        loadSeriesInfo()
        // Do any additional setup after loading the view.
    }
    
    //MARK: - Private functions
    private func prepareCollectionView() {
        mHeight = collectionView.frame.height
        mWidth = view.frame.width/4.2
        sectionInsets = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width/40, bottom: 0, right: UIScreen.main.bounds.width/40)
    }
    private func loadSeriesInfo() {
        
        AniListService.getDetailedSeries(withID: seriesId)
            .then { anime in
                self.series = anime
            }.then { anime in
                self.setView(with: self.series)
            }.catch { error in
                UIAlertController(title: "", message: "\(error)", preferredStyle: .alert).show(self, sender: nil)
            }
    }
    
    private func setView(with anime: Anime) {
        
        ImageDownloadHelper.getImage(fromURL: URL(string: anime.imageURL)!)
            .then { image in
                self.seriesImage.image = image
            }.then {
                self.episodesLabel.text = "Episodes: \(anime.episodes)"
            }.then {
                self.startDateLabel.text = "Start date: \(anime.startDate)"
            }.then {
                self.endDateLabel.text = "End date:  \(anime.endDate)"
            }.then {
                self.descriptionLabel.text = "\(anime.description)"
            }.then {
                self.titleLabel.text = "\(anime.title)"
            }.then {
                self.seriesCharacters = anime.characters
            }.then {
                self.collectionView.reloadData()
            }.catch { error in
                UIAlertController(title: "", message: "", preferredStyle: .alert).show(self, sender: nil)
            }
    }
}

//MARK: UICollectionViewDataSource

extension SeriesDetailViewController: UICollectionViewDataSource {
    //1
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1  }
    
    //2
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return seriesCharacters.count
    }
    
    //3
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.reusableIdentifier, for: indexPath) as! CollectionCell
        cell.setCharacter(withCharacter: seriesCharacters[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SeriesDetailViewController: UICollectionViewDelegateFlowLayout {
    //Especificamos tamaños de celdas de acuerdo al dispositivo
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: mWidth, height: mHeight)
    }
    
    //Generamos insets de acuerdo al tamaño de la pantalla
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}

