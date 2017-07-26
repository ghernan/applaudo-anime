//
//  SearchCell.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/25/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit
import PromiseKit

class SearchCell: CategoryCell {
    
    //IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    //MARK: Public properties
    var selectedSeries:((Int) -> Void)?
    //MARK: - Private properties
    
    fileprivate var mWidth: CGFloat = 0
    fileprivate var mHeight: CGFloat = 0
    fileprivate var sectionInsets = UIEdgeInsets()
    fileprivate var series: [Series] = []
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionViewLayoutCalculations()
        
    }
    
    //MARK: - Private Methods
    
    private func collectionViewLayoutCalculations() {
        mHeight = self.frame.height - 10
        mWidth = self.frame.width/4.2
        sectionInsets = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width/40, bottom: 0, right: UIScreen.main.bounds.width/40)
    }
}



