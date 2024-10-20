//
//  ImageDetailsViewModel.swift
//  BattleBucks-InterViewTask
//
//  Created by Gagandeep Sidhu on 20/10/24.
//

import SwiftUI

final class ImageDetailsViewModel: ObservableObject {
    @Published var imageModel: ImageModel
    @Published var uiImage: UIImage?
    @Published var isLoading: Bool = false
    @Published var hasError: Bool = false
    @Published var showBoundaryAlert: Bool = false
    @Published var alertMessage: String = ""
    
    var images: [ImageModel] // Array of images
    var currentIndex: Int // Current index of the displayed image
    
    init(images: [ImageModel], currentIndex: Int) {
        self.images = images
        self.currentIndex = currentIndex
        self.imageModel = images[currentIndex] // Initialize with the current image model
    }
    
    // Computed property for the previous image
    var previousUIImage: UIImage? {
        guard currentIndex > 0 else { return nil }
        let previousImageModel = images[currentIndex - 1]
        if let url = URL(string: previousImageModel.url) {
            return ImageCache.shared.getImage(for: url) // Get cached image for previous image URL
        }
        return nil
    }
    
    // Computed property for the next image
    var nextUIImage: UIImage? {
        guard currentIndex < images.count - 1 else { return nil }
        let nextImageModel = images[currentIndex + 1]
        if let url = URL(string: nextImageModel.url) {
            return ImageCache.shared.getImage(for: url) // Get cached image for next image URL
        }
        return nil
    }
    
    // Move to the next image
    func nextImage() {
        if currentIndex < images.count - 1 {
            currentIndex += 1
            updateImageModel() // Update to the next image
        } else {
            showBoundaryAlert = true
            alertMessage = "You have reached the last image." // Alert for the last image
        }
    }
    
    // Move to the previous image
    func previousImage() {
        if currentIndex > 0 {
            currentIndex -= 1
            updateImageModel() // Update to the previous image
        } else {
            showBoundaryAlert = true
            alertMessage = "You are at the first image." // Alert for the first image
        }
    }
    
    // Update the current image model and reload the image
    func updateImageModel() {
        uiImage = nil // Clear the current image
        imageModel = images[currentIndex] // Update to the new image model
    }
}
