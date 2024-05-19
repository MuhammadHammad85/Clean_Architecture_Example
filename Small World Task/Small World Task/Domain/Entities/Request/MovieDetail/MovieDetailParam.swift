//
//  MovieDetailParam.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation

struct MovieDetailRequest: Codable {
   
    let apiKey: String
    
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
    }
}
