//
//  MovieListParam.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation

struct MovieListParam: Codable {
    
    let apiKey: String
    let page: Int
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case page   = "page"
    }
}
