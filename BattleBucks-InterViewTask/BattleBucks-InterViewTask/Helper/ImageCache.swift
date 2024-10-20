//
//  ImageCache.swift
//  BattleBucks-InterViewTask
//
//  Created by Gagandeep Sidhu on 20/10/24.
//

import SwiftUI

// Singleton class to handle image caching using NSCache
class ImageCache {
    
    // Shared singleton instance of ImageCache
    static let shared = ImageCache()
    
    // Private initializer to prevent instantiation from outside the class
    private init() {}

    // NSCache to store images, using NSURL as the key and UIImage as the value
    private var cache = NSCache<NSURL, UIImage>()
    
    // Function to retrieve an image from cache for a given URL
    // - Parameter url: The URL of the image to retrieve
    // - Returns: The cached UIImage if available, otherwise nil
    func getImage(for url: URL) -> UIImage? {
        return cache.object(forKey: url as NSURL)
    }
    
    // Function to save an image to the cache for a given URL
    // - Parameters:
    //   - image: The UIImage to cache
    //   - url: The URL to associate with the image in the cache
    func saveImage(_ image: UIImage, for url: URL) {
        cache.setObject(image, forKey: url as NSURL)
    }
}
