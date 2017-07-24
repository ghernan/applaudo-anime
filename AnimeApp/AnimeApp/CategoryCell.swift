//
//  CategoryCell.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/24/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

class CategoryCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    public static var reusableIdentifier: String{
        return String(describing: self)
    }

   

}
