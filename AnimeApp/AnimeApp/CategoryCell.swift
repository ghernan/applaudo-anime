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
    fileprivate var isCategorySet = false
    fileprivate var currentPage = 0
    fileprivate var seriesType: SeriesType = .anime
    fileprivate var category = Category()
    
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
    
    public func setCategory(withSeriesType type: SeriesType, fromCategory category: Category) {
        self.category = category
        self.seriesType = type
        isCategorySet = true
        currentPage += 1
        firstly {
            
            AniListService.getSeries(withSeriesType: type, fromCategory: category, inPage: currentPage)
            }.then { series in
                self.series.append(contentsOf: series)
            }.then { categories in
                self.collectionView.reloadData()
            }.catch{ error in
                
            }
    }
    
    public func setHeight(height: CGFloat) {
        
        mHeight = height
    }
    
    //MARK: - Private Methods
    private func collectionViewLayoutCalculations() {
        
        mWidth = self.frame.width/4.2
        sectionInsets = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width/40, bottom: 0, right: UIScreen.main.bounds.width/40)
    }
    
}

//MARK: UICollectionViewDelegate

extension CategoryCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        selectedSeries!(series[indexPath.row].id)       
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        if isCategorySet {
            if indexPath.row >= series.count-5 {
                
                self.setCategory(withSeriesType: self.seriesType, fromCategory: self.category)
            }
        }
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
