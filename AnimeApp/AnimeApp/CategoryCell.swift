//
//  CategoryCell.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/24/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit
import PromiseKit

class CategoryCell: UITableViewCell {
    
    //IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    //MARK: Public properties
    var selectedSeries:((Int) -> Void)?
    //MARK: - Private properties
    
    fileprivate var mWidth: CGFloat = 0
    fileprivate var mHeight: CGFloat = 0
    fileprivate var sectionInsets = UIEdgeInsets()
    fileprivate var series: [Series] = []
    fileprivate var seriesType: SeriesType?
    fileprivate var genre: Category?
    fileprivate var currentPage = 1
    
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionViewLayoutCalculations()
        
    }
    //MARK: Public methods
    public func setSeries(withSeriesList series: [Series]) {
        
        self.series = series
        collectionView.reloadData()
    }
    
    public static var reusableIdentifier: String {
        return String(describing: self)
    }
    
    public func setCategory(withSeriesType type: SeriesType, fromCategory category: Category, inPage page: Int = 1) {
        self.genre = category
        self.seriesType = type
        
        
            
        AniListManager.getSeries(withSeriesType: type, fromCategory: category, inPage: page)
            .then { series in
                self.series = series
                //TODO:
                //This should do the trick for pagination can not figure out why it doesn't.
                //self.joinCollection(withSeriesList: series)
            }.then {
                self.collectionView.reloadData()
            }.catch{ error in
                print(error)
            }
    }
    
    public func setHeight(height: CGFloat) {
        
        mHeight = height
    }
    
    
    //MARK: - Private Methods
    private func joinCollection(withSeriesList series: [Series]) {
        if self.series.count == 0 {
            self.series = series
        } else {
            self.series.append(contentsOf: series)
        }
    }
    private func collectionViewLayoutCalculations() {
        
        mWidth = self.frame.width/4.2
        sectionInsets = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width/40, bottom: 0, right: UIScreen.main.bounds.width/40)
    }
    
}

//MARK: UICollectionViewDelegate

extension CategoryCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let selectedSeries = selectedSeries {
            selectedSeries(series[indexPath.row].id)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        //Commented since pagination is not working.
        
//        if indexPath.item == series.count - 5 {
//            print(indexPath.item)
//            guard let type = self.seriesType else {
//                
//                return
//            }
//            guard let category = self.genre else {
//                
//                return
//            }
//            currentPage += 1
//            
//            //setCategory(withSeriesType: type, fromCategory: category, inPage: currentPage)
//        }
    }
}
    


//MARK: UICollectionViewDataSource

extension CategoryCell: UICollectionViewDataSource {
   
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return series.count
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.reusableIdentifier, for: indexPath) as! CollectionCell
        cell.setSeries(withSeries: series[indexPath.row])
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension CategoryCell: UICollectionViewDelegateFlowLayout {
    
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
