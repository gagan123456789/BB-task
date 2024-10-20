//
//  BattleBucks_InterViewTaskTests.swift
//  BattleBucks-InterViewTaskTests
//
//  Created by Gagandeep Sidhu on 20/10/24.
//

import XCTest
import SwiftUI

@testable import BattleBucks_InterViewTask

final class ImageViewModelTests: XCTestCase {
    
    var viewModel: ImageViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = ImageViewModel(imageUrl: "https://via.placeholder.com/150/92c952") // Use a valid test image URL
    }

    func testInitialImageLoading() {
        XCTAssertNil(viewModel.uiImage)
    }

    func testLoadImageFromCache() {
        // Assume the image is already cached for this URL
        let testImage = UIImage(systemName: "photo")! // Sample image
        ImageCache.shared.saveImage(testImage, for: URL(string: viewModel.imageUrl)!)
        
        viewModel.loadImage() // Reload the image
        XCTAssertNotNil(viewModel.uiImage)
        XCTAssertFalse(viewModel.isLoading)
        XCTAssertFalse(viewModel.hasError)
    }


    func testLoadImageFailure() {
        viewModel = ImageViewModel(imageUrl: "https://via.placeholder.com/150/92c952") // Invalid URL
        viewModel.loadImage() // Call loadImage to trigger network fetch
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            XCTAssertNil(self.viewModel.uiImage)
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertTrue(self.viewModel.hasError)
        }
    }
}


final class ImageDetailsViewModelTests: XCTestCase {
    
    var viewModel: ImageDetailsViewModel!
    var images: [ImageModel] = []

    override func setUp() {
        super.setUp()
        // Create sample images for testing
        images = [
            ImageModel(id: 1, albumId: 1, title: "Image 1", url: "https://via.placeholder.com/150/24f355", thumbnailUrl: "https://via.placeholder.com/150/771796"),
            ImageModel(id: 2, albumId: 1, title: "Image 2", url: "https://via.placeholder.com/600/24f355", thumbnailUrl: "https://via.placeholder.com/150/24f35"),
            ImageModel(id: 3, albumId: 1, title: "Image 3", url: "https://via.placeholder.com/600/f66b97", thumbnailUrl: "https://via.placeholder.com/150/f66b97"),
        ]
        viewModel = ImageDetailsViewModel(images: images, currentIndex: 0)
    }

    func testInitialImage() {
        XCTAssertEqual(viewModel.imageModel.title, "Image 1")
        XCTAssertEqual(viewModel.currentIndex, 0)
    }

    func testNextImage() {
        viewModel.nextImage()
        XCTAssertEqual(viewModel.currentIndex, 1)
        XCTAssertEqual(viewModel.imageModel.title, "Image 2")

        viewModel.nextImage()
        XCTAssertEqual(viewModel.currentIndex, 2)
        XCTAssertEqual(viewModel.imageModel.title, "Image 3")

        viewModel.nextImage() // Attempt to go beyond the last image
        XCTAssertTrue(viewModel.showBoundaryAlert)
        XCTAssertEqual(viewModel.alertMessage, "You have reached the last image.")
    }

    func testPreviousImage() {
        viewModel.currentIndex = 2 // Start at last image
        viewModel.previousImage()
        XCTAssertEqual(viewModel.currentIndex, 1)
        XCTAssertEqual(viewModel.imageModel.title, "Image 2")

        viewModel.previousImage()
        XCTAssertEqual(viewModel.currentIndex, 0)
        XCTAssertEqual(viewModel.imageModel.title, "Image 1")

        viewModel.previousImage() // Attempt to go before the first image
        XCTAssertTrue(viewModel.showBoundaryAlert)
        XCTAssertEqual(viewModel.alertMessage, "You are at the first image.")
    }

    func testUpdateImageModel() {
        viewModel.updateImageModel() // Should set uiImage to nil and update imageModel
        XCTAssertNil(viewModel.uiImage)
        XCTAssertEqual(viewModel.imageModel.title, "Image 1") // Should still be the first image
    }
}
