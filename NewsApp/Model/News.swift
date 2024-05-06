//
//  News.swift
//  NewsApp
//
//  Created by Abhishek J  on 06/05/24.
//

import Foundation

struct NewsArticle: Identifiable, Codable {
    var id = UUID() // Unique identifier
    var title: String
    var description: String?
    var author:String?
    var urlToImage: String?
    
    // Coding keys to map JSON
    enum CodingKeys: String, CodingKey {
        case title, description, urlToImage,author
    }
}

