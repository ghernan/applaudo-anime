//
//  SeriesDetailViewController.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/25/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit
import XCDYouTubeKit

class SeriesDetailViewController: UIViewController {

    //IBOutlets
    
    @IBOutlet weak var centerPopupConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var backGroundButton: UIButton!
    @IBOutlet weak var seriesImage: UIImageView!
    
    @IBOutlet weak var episodesLabel: UILabel!
    
    @IBOutlet weak var startDateLabel: UILabel!
    
    @IBOutlet weak var endDateLabel: UILabel!
    
    @IBOutlet weak var studioLabel: UILabel!
    
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var youtubeButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var popUpVideo: UIView!
    
    @IBOutlet weak var collectionView: UICollectionView!    
    
    //MARK: - IBAction
    
    @IBAction func exit(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func playVideo(_ sender: Any) {
        
        centerPopupConstraint.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.backGroundButton.alpha = 0.65
            self.backGroundButton.isHidden = false
            self.videoPlayer = XCDYouTubeVideoPlayerViewController(videoIdentifier: self.series.youTubeID)
            self.videoPlayer.present(in: self.popUpVideo)
            self.videoPlayer.moviePlayer.play()
        })
        
        
    }
    
    @IBAction func closePopUp(_ sender: Any) {
        centerPopupConstraint.constant = -400
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
            self.backGroundButton.alpha = 0.0
            self.backGroundButton.isHidden = true
            self.videoPlayer.moviePlayer.stop()
        })
        
    }
    
    
    
    //MARK: - Public properties
    var seriesId = 0
    
    //MARK: Private properties
    private var videoPlayer = XCDYouTubeVideoPlayerViewController()
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
    private func prepareVideoButton() {
        youtubeButton.isHidden = series.youTubeID != "" ?
            false :
            true
        popUpVideo.layer.cornerRadius = 5
        popUpVideo.layer.masksToBounds = true
    }
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
            }.then { anime in
                self.prepareVideoButton()
            }.catch { error in
                UIAlertController(title: "", message: "\(error)", preferredStyle: .alert).show(self, sender: nil)
            }
    }
    
    private func setView(with anime: Anime) {
        
        let airingText = anime.seriesType == SeriesType.anime.urlParamString() ?
            "Anime Episodes: \(anime.episodes)" :
            "Manga Chapters: \(anime.chapters)"
        ImageDownloadHelper.getImage(fromURL: URL(string: anime.imageURL)!)
            .then { image in
                self.seriesImage.image = image
            }.then {
                self.episodesLabel.text = airingText
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
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: mWidth, height: mHeight)
    }
    
    
    public func collectionView(_ collectionView: UICollectionView,
                               layout collectionViewLayout: UICollectionViewLayout,
                               insetForSectionAt section: Int) -> UIEdgeInsets {
        return sectionInsets
    }
}

