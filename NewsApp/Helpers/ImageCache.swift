//
//  ImageCache.swift
//  NewsApp
//
//  Created by Abhishek J  on 06/05/24.
//

import UIKit
import Foundation

class ImageCache {
    static let shared = ImageCache() // Singleton instance
    
    private var cache = NSCache<NSString, UIImage>() // NSCache for image caching

    func getImage(forKey key: String) -> UIImage? {
        return cache.object(forKey: key as NSString) // Retrieve image from cache
    }

    func setImage(_ image: UIImage, forKey key: String) {
        cache.setObject(image, forKey: key as NSString) // Store image in cache
    }
}


