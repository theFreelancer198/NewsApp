//
//  NewsDetailVC.swift
//  NewsApp
//
//  Created by Abhishek J  on 06/05/24.
//

import SwiftUI

struct NewsDetailView: View {
    let article: NewsArticle // The article to display
    
    var body: some View {
        ScrollView { // Allow scrolling for large content
            VStack(alignment: .leading, spacing: 20) {
                
                Text(article.title) // Display the article's title
                    .font(.largeTitle)
                Text(article.author ?? "Unknown")
                    .font(.body)
                    .foregroundColor(.gray)
                if let urlToImage = article.urlToImage, let imageURL = URL(string: urlToImage) {
                    //CachedAsyncImage(url: imageURL,isloa)
                    CachedAsyncImage(url: imageURL)
                        .aspectRatio(contentMode: .fit)
                    
                }
                if let description = article.description { // Display the article's description
                    Text(description)
                        .font(.body)
                        .foregroundColor(.black) // Use a gray color for body text
                }
            }
            .padding()
        }
    }
}

