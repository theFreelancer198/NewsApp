//
//  ContentView.swift
//  WeatherApp
//
//  Created by Abhishek J  on 06/05/24.
//

import SwiftUI
import CoreData

struct NewsCollectionView: View {
    @ObservedObject var viewModel = NewsViewModel() // Observing the view model

    let columns = [ // Define the grid structure with two columns
        GridItem(.flexible()),
        GridItem(.flexible()),
    ]

    var body: some View {
        NavigationStack { // Enable navigation with NavigationStack
            if let error = viewModel.error { // Check for errors
                Text("Error: \(error)") // Display error message
                    .navigationTitle("Top Headlines") // Set navigation bar title
            } else {
                ScrollView { // Enable scrolling for the collection
                    LazyVGrid(columns: columns, spacing: 20) { // Use LazyVGrid for grid layout
                        ForEach(viewModel.articles) { article in
                            NavigationLink(destination: NewsDetailView(article: article)) { // Navigate to detail view
                                VStack { // Display each article
                                    if let urlToImage = article.urlToImage, let imageURL = URL(string: urlToImage) {
                                        CachedAsyncImage(url: imageURL)
                                            .aspectRatio(contentMode: .fit)
                                    }
                                    Text(article.title)
                                        .font(.headline)
                                        .padding(.top, 5)
                                    if let description = article.description {
                                        Text(description)
                                            .font(.subheadline)
                                            .foregroundColor(.gray)
                                            .lineLimit(3) // Limit to avoid overflow
                                    }
                                }
                                .padding()
                                .background(Color.white)
                                .cornerRadius(10)
                                .shadow(color: .gray, radius: 5)
                            }
                        }
                    }
                    .padding() // Add padding around the grid
                }
                .navigationTitle("Top Headlines") // Set the navigation bar title
            }
        }
    }
}
