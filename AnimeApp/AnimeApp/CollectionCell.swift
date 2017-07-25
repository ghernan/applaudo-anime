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
    override func prepareForReuse() {
        seriesImage.image = nil
        seriesNameLabel.text = nil
        super.prepareForReuse()
    }
    func setSeries(withSeries series: Series) {
        self.seriesImage.image = nil
        ImageDownloadHelper.getImage(fromURL: URL(string: series.imageURL)!)
            .then { image in
                self.seriesImage.image = image
            }.then {
                self.seriesNameLabel.text = series.title
            }.catch { error in
        
            }
        
        
    
    }
    
}
