//
//  MovieListResponse.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation


class MovieListResponse: BaseResponse, Codable {
    var code: Int?
    var message: String?
    var succes: Bool?
    var result: [MovieLists]?
    var totalPages: Int?
    var page: Int?

    enum CodingKeys: String, CodingKey{
        case code = "code"
        case message = "message"
        case succes = "succes"
        case result = "results"
        case totalPages = "total_pages"
        case page = "page"
    }

}

class MovieLists: Codable {

    var id: Int?
    var title: String?
    var description: String?
    var releaseDate: String?
    var posterPath: String?

    enum CodingKeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case description = "overview"
        case releaseDate = "release_date"
        case posterPath = "poster_path"
    }

}

