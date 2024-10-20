//
//  ImageView.swift
//  BattleBucks-InterViewTask
//
//  Created by Gagandeep Sidhu on 20/10/24.
//

import SwiftUI

// View for displaying an image, with loading and error handling states
struct ImageView: View {
    @ObservedObject var viewModel: ImageViewModel
    
    var body: some View {
        ZStack {
            if let image = viewModel.uiImage {
                Image(uiImage: image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .clipped()
            } else if viewModel.isLoading {
                ProgressView() // Show loading indicator
                    .frame(alignment: .center)
            } else if viewModel.hasError {
                Text("Error loading. Tap to retry.") // Error message
                    .foregroundColor(.red)
                    .font(.caption)
                    .multilineTextAlignment(.center)
                    .padding(5)
                    .onTapGesture {
                        viewModel.loadImage() // Retry on tap
                    }
            }
        }
    }
}
