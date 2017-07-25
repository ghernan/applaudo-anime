//
//  CategoryCell.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/24/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {
    
    //IBOutlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - Private properties
    
    fileprivate var mWidth: CGFloat = 0
    fileprivate var mHeight: CGFloat = 0
    fileprivate var sectionInsets = UIEdgeInsets()
    
    //MARK: - Life cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        collectionView.delegate = self
        collectionView.dataSource = self
        mHeight = self.frame.height
        mWidth = self.frame.width/4.2
        sectionInsets = UIEdgeInsets(top: 0, left: UIScreen.main.bounds.width/40, bottom: 0, right: UIScreen.main.bounds.width/40)
        // Initialization code
    }
    
    public static var reusableIdentifier: String{
        return String(describing: self)
    }

   

}

//MARK: UICollectionViewDelegate

extension CategoryCell: UICollectionViewDelegate {

}

//MARK: UICollectionViewDataSource

extension CategoryCell: UICollectionViewDataSource {
    //1
    private func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        
        return 1  }
    
    //2
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 8
    }
    
    //3
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        print("entre")
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CollectionCell.reusableIdentifier, for: indexPath) as! CollectionCell
        
        
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension CategoryCell: UICollectionViewDelegateFlowLayout {
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


