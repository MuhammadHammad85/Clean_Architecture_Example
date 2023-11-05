//
//  MovieDetailResponse.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation

struct MovieDetailResponse: BaseResponse , Codable {
    var code: Int?
    var message: String?
    var succes: Bool?
    var id: Int?
    var title: String?
    var homepageLink: String?
    var description: String?
    var releaseDate: String?
    var posterImage: String?
    
    init( id: Int?, title: String?, description: String?, releaseDate: String?, posterImage: String?) {
        self.id = id
        self.title = title
        self.description = description
        self.releaseDate = releaseDate
        self.posterImage = posterImage
    }
    
    enum CodingKeys: String, CodingKey {
        case id
        case title
        case homepageLink = "homepage"
        case description = "overview"
        case releaseDate = "release_date"
        case posterImage = "poster_path"
    }
}
