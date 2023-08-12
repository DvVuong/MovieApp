//
//  ImageManager.swift
//  MovieApp
//
//  Created by mr.root on 6/28/23.
//

import UIKit
import Combine

final class ImageManager {
    static var share = ImageManager()
       private  var cache = NSCache<NSString, UIImage>()
       
       func fetchImage(with url: String, completion: @escaping (UIImage) -> Void) {
           let path = APIPath.BASER_IMAGE_URL + url
           let keyCache = NSString(string: path)
           if let image = cache.object(forKey: keyCache)  {
               completion(image)
               return
           }
           
           guard let url = URL(string: path) else { return }
           let task = URLSession.shared.dataTask(with: url) { data, _, error in
               if error != nil { return}
               guard let data = data, let image = UIImage(data: data) else { return }
               self.cache.setObject(image, forKey: keyCache)
               completion(image)
           }
           task.resume()
       }
}
