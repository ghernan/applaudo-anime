//
//  CollectionCell.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/24/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

class CollectionCell: UICollectionViewCell {
    
    //IBOutlets
    @IBOutlet weak var seriesImage: UIImageView!
    @IBOutlet weak var seriesNameLabel: UILabel!
    
    public static var reusableIdentifier: String{
        return String(describing: self)
    }
    
    func setSeries(withSeries series: Series) {
        
        seriesNameLabel.text = series.title
    
    }
    
}
