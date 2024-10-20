//
//  ImageDetailsView.swift
//  BattleBucks-InterViewTask
//
//  Created by Gagandeep Sidhu on 20/10/24.
//

import SwiftUI

// View for displaying image details and enabling swipe navigation
struct ImageDetailView: View {
    @ObservedObject var viewModel: ImageDetailsViewModel
    @State private var dragOffset: CGFloat = 0
    @State private var isDragging = false

    var body: some View {
        GeometryReader { geometry in
            VStack(spacing: 20) {
                Text(viewModel.imageModel.title) // Display image title
                    .font(.title)
                    .frame(height: 100)
                    .frame(maxWidth: .infinity, alignment: .center)

                ImageView(viewModel: .init(imageUrl: viewModel.imageModel.url)) // Display image
                    .frame(height: geometry.size.width - 20)

                Spacer()
            }
            .padding(.horizontal, 10)
            .contentShape(Rectangle()) // Makes the whole VStack tappable
            .gesture(
                DragGesture()
                    .onChanged { value in
                        dragOffset = value.translation.width // Update drag offset
                        isDragging = true
                    }
                    .onEnded { value in
                        // Navigate to the next or previous image based on drag direction
                        if value.translation.width < 0 {
                            viewModel.nextImage()
                        } else if value.translation.width > 0 {
                            viewModel.previousImage()
                        }
                    }
            )
            .toast(isPresented: $viewModel.showBoundaryAlert, message: viewModel.alertMessage) // Show boundary alert
        }
    }
}
