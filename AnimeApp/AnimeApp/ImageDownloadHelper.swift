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
//TODO:
//Class that pretends to cache all images in order to avoid the weird bug when re using a cell. Still needs improvement.

class ImageDownloadHelper {
    
    static let imageCache = NSCache<AnyObject, AnyObject>()
    static var image: UIImage?
    static var imageUrlString = ""
    private static let imageDownloader = ImageDownloader(
        configuration: ImageDownloader.defaultURLSessionConfiguration(),
        downloadPrioritization: .fifo,
        maximumActiveDownloads: 10,
        imageCache: AutoPurgingImageCache()
    )
    
    //MARK: - Life cycle
    private init() {
        
    }
    
    static func getImage(fromURL url: URL) -> Promise<UIImage> {
        
        return Promise { fulfill, reject in
            
            let urlRequest = URLRequest(url: url)
            
            imageUrlString = url.absoluteString
            
            image = nil
            
            if let imageFromCache = imageCache.object(forKey: url.absoluteString as AnyObject) as? UIImage {
                self.image = imageFromCache
                fulfill(self.image!)
                return
            }
            imageDownloader.download(urlRequest) { response in
                guard let image = response.result.value else {
                    reject(response.error!)
                    return
                }
                DispatchQueue.main.async {
                    let imageToCache = image
                    if self.imageUrlString == url.absoluteString {
                        self.image = imageToCache
                    }
                    imageCache.setObject(imageToCache, forKey: url.absoluteString as AnyObject)
                    fulfill(image)
                    
                }
                
            }
        }
    }
    
}
