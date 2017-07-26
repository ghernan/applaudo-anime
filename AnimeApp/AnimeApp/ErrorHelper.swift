//
//  ErrorHelper.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/26/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import UIKit

class ErrorHelper {
    
    static func throwAlert(withError error: Error, on viewController: UIViewController) {
        
         UIAlertController(title: "", message: "ERROR: \(error)", preferredStyle: .alert).show(viewController, sender: viewController)
    }
}
