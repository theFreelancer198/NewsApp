//
//  NewsViewModel.swift
//  NewsApp
//
//  Created by Abhishek J  on 06/05/24.
//

import Foundation
import Combine

class NewsViewModel: ObservableObject {
    @Published var articles: [NewsArticle] = []
    @Published var error: String? = nil
    
    let apiKey = "31d5d8d390544dcb854f7fb62abf905e"
    var url : URL?// The URL to fetch top headlines
    
    init() {
        url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&apiKey=\(apiKey)")!
        fetchNews() // Fetch the news on initialization
    }

    func fetchNews() {
        Task { // Use Task to start an async operation
            do {
                let (data, _) = try await URLSession.shared.data(from: url!) // Fetch data from the URL
                let decoder = JSONDecoder() // Create a JSON decoder
                let result = try decoder.decode(NewsResponse.self, from: data) // Decode the data
                    DispatchQueue.main.async {
                        self.articles = result.articles // Update the articles array
                        self.articles.sort(by: {$0.author ?? "" < $1.author ?? ""})
                    }
               
                
            } catch {
                DispatchQueue.main.async {
                    self.error = "Failed to fetch news." // Set an error message in case of failure
                }
            }
        }
    }
}

// Additional struct to represent the API response
struct NewsResponse: Codable {
    var articles: [NewsArticle] // The articles in the response
}
