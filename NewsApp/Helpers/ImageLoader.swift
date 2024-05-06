//
//  ImageLoader.swift
//  NewsApp
//
//  Created by Abhishek J  on 06/05/24.
//

import SwiftUI

struct CachedAsyncImage: View {
    let url: URL // The image URL
    
    @State private var uiImage: UIImage? // The loaded UIImage
    @State private var isLoading = true // Loading state
    
    var body: some View {
        Group {
            if let uiImage = uiImage { // If the image is available
                Image(uiImage: uiImage) // Display it
                    .resizable() // Make it resizable
            } else if isLoading { // If it's loading
                ProgressView() // Show a loading indicator
            } else {
                EmptyView() // If no image and not loading, show nothing
            }
        }
        .onAppear {
            loadImage() // Load the image when the view appears
        }
    }
    
    private func loadImage() {
        if let cachedImage = ImageCache.shared.getImage(forKey: url.absoluteString) { // Check cache
            self.uiImage = cachedImage // Use cached image
        } else { // If not in cache, load from network
            isLoading = true
            Task {
                do {
                    let (data, _) = try await URLSession.shared.data(from: url) // Fetch data
                    if let image = UIImage(data: data) { // Convert data to UIImage
                        ImageCache.shared.setImage(image, forKey: url.absoluteString) // Cache the image
                        DispatchQueue.main.async {
                            self.uiImage = image // Set the UIImage
                            self.isLoading = false // Update loading state
                        }
                    }
                } catch {
                    print("Error loading image: \(error)") // Handle errors
                    DispatchQueue.main.async {
                        self.isLoading = false
                    }
                }
            }
        }
    }
}
