//
//  ImageViewModel.swift
//  BattleBucks-InterViewTask
//
//  Created by Gagandeep Sidhu on 20/10/24.
//

import SwiftUI

final class ImageViewModel: ObservableObject {
    @Published var imageUrl: String
    @Published var uiImage: UIImage?
    @Published var isLoading: Bool = false
    @Published var hasError: Bool = false
    
    init(imageUrl: String) {
        self.imageUrl = imageUrl
        self.loadImage() // Load image when the view model is initialized
    }
    
    func downloadImage(for url: URL, completion: @escaping (UIImage?) -> Void) {
        NetworkManager.shared.loadImage(from: url) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let image):
                    ImageCache.shared.saveImage(image, for: url) // Cache the downloaded image
                    completion(image)
                case .failure:
                    completion(nil) // Return nil if download fails
                }
            }
        }
    }
    
    func loadImage() {
        guard let url = URL(string: imageUrl) else {
            hasError = true // Set error if URL is invalid
            return
        }
        
        isLoading = true // Set loading state
        hasError = false // Reset error state
        
        if let cachedImage = ImageCache.shared.getImage(for: url) {
            uiImage = cachedImage // Use cached image if available
            isLoading = false // Reset loading state
        } else {
            downloadImage(for: url) { image in
                DispatchQueue.main.async {
                    if let image = image {
                        self.uiImage = image // Set the downloaded image
                    } else {
                        self.hasError = true // Set error if download fails
                    }
                    self.isLoading = false // Reset loading state
                }
            }
        }
    }
}
