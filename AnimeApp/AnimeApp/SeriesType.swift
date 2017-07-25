//
//  SeriesType.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/25/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation

enum SeriesType: Int {
    
    case anime
    case manga
    
    func urlParamString() -> String {
        switch self {
        case .anime:
            return "anime"
        case .manga:
            return "manga"
       
        }
    }

}
