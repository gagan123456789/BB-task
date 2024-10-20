//
//  ImageListView.swift
//  BattleBucks-InterViewTask
//
//  Created by Gagandeep Sidhu on 20/10/24.
//

import SwiftUI

// View to display a list of images in a navigation interface
struct ImageListView: View {
    @ObservedObject var viewModel: ImageListViewModel

    var body: some View {
        NavigationView {
            GeometryReader { geometry in
                let width = geometry.size.width
                let columnCount = max(1, Int(width / 100)) // Adjust the divisor for desired item width
                let columns = Array(repeating: GridItem(.flexible()), count: columnCount)

                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.images.indices, id: \.self) { index in
                            NavigationLink(destination: ImageDetailView(viewModel: .init(images: viewModel.images, currentIndex: index))) {
                                ImageView(viewModel: .init(imageUrl: viewModel.images[index].thumbnailUrl))
                                    .frame(width: 100, height: 100) // Set fixed size for the image
                            }
                            .buttonStyle(PlainButtonStyle()) // Use plain button style
                        }
                    }
                    .padding() // Add padding around the grid
                }
            }
            .navigationTitle("Image Gallery") // Set the title of the navigation bar
        }
    }
}
