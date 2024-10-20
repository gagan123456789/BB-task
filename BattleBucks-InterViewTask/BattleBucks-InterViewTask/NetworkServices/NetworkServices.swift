//
//  NetworkServices.swift
//  BattleBucks-InterViewTask
//
//  Created by Gagandeep Sidhu on 20/10/24.
//

import Combine
import SwiftUI

// Singleton class to manage network requests
class NetworkManager {
    
    // Shared singleton instance of NetworkManager
    static let shared = NetworkManager()
    
    // URLSession used to manage network requests
    private var session: URLSession
    
    // Private initializer to configure the URLSession
    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 60 // Set request timeout to 60 seconds
        self.session = URLSession(configuration: configuration)
    }
    
    // Function to load an image from a given URL
    func loadImage(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error)) // Return error in completion handler
                return
            }
            
            // Validate the response and data
            guard let data = data, let image = UIImage(data: data) else {
                // Create a custom error and return it
                let error = NSError(domain: "Invalid data", code: -1, userInfo: nil)
                completion(.failure(error))
                return
            }
            
            // Successfully return the downloaded image
            completion(.success(image)) // Use Result type for success
        }
        task.resume() // Start the task
    }
    
    // Fetch images from the API
    func fetchImages(completion: @escaping (Result<[ImageModel], Error>) -> Void) {
        let urlString = "https://jsonplaceholder.typicode.com/photos" // API endpoint
        
        // Validate and create URL
        guard let url = URL(string: urlString) else {
            let error = NSError(domain: "Invalid URL", code: -1, userInfo: nil)
            completion(.failure(error))
            return
        }

        let task = session.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error)) // Return error in completion handler
                return
            }
            guard let data = data else {
                let error = NSError(domain: "No data", code: -1, userInfo: nil)
                completion(.failure(error)) // Return error if no data
                return
            }
            do {
                // Decode the data into an array of ImageModel
                let decodedImages = try JSONDecoder().decode([ImageModel].self, from: data)
                completion(.success(decodedImages)) // Return decoded images
            } catch {
                completion(.failure(error)) // Return decoding error
            }
        }
        task.resume() // Start the network task
    }
}
