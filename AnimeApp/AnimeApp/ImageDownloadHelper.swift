//
//  ImageDownloadHelper.swift
//  AnimeApp
//
//  Created by Antonio  Hernandez  on 7/24/17.
//  Copyright © 2017 Antonio  Hernandez . All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage
import PromiseKit

class ImageDownloadHelper {
    
    private static let imageDownloader = ImageDownloader(
        configuration: ImageDownloader.defaultURLSessionConfiguration(),
        downloadPrioritization: .fifo,
        maximumActiveDownloads: 10,
        imageCache: AutoPurgingImageCache()
    )
    
    //MARK: - Life cycle
    private init() {
        
    }
    //MARK: - Static functions

    static func getImage(fromURL url: URL) -> Promise<UIImage> {
        return Promise { fulfill, reject in
            let urlRequest = URLRequest(url: url)
            imageDownloader.download(urlRequest) { response in
                guard let image = response.result.value else {
                    reject(response.error!)
                    return
                }
                fulfill(image)
            }
        }       
    }
    
}
