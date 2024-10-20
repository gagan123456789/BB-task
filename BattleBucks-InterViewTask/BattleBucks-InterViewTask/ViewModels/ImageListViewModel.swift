//
//  ImageListViewModel.swift
//  BattleBucks-InterViewTask
//
//  Created by Gagandeep Sidhu on 20/10/24.
//

import Foundation

// ViewModel for managing the image list
final class ImageListViewModel: ObservableObject {
    @Published var images: [ImageModel] = []
    @Published var selectedIndex: Int = 0

    init() {
        fetchImages()
    }
    
    // Fetch images using NetworkManager
    func fetchImages() {
        NetworkManager.shared.fetchImages { [weak self] result in
            DispatchQueue.main.async { // Ensure UI updates happen on the main thread
                switch result {
                case .success(let decodedImages):
                    self?.images = decodedImages // Update images on success
                case .failure(let error):
                    print("Error fetching images: \(error.localizedDescription)") // Log error
                }
            }
        }
    }
}
