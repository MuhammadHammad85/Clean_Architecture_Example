//
//  AppURL.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation

class AppURL {
    
    static let environment = Domains.dev
    
    private struct Domains {
        static let dev = "https://api.themoviedb.org/3/"
        static let stag = ""
        static let qa = ""
        static let production = ""
    }
    
    static func reguesURL(path : String) -> String {
        return environment + path
    }
    
}

class Path {
    
    static var discoverMovies = "discover/movie"
   
    static func getDetails(_ id: Int)-> String{
        return "/movie/\(id)"
    }
    
}

struct MediaURL { //PayFastServer Image
    
    static let environment = Domains.dev
    
    private struct Domains {
        static let dev = "https://image.tmdb.org/t/p/w300"
        static let stag = ""
        static let qa = ""
        static let production = ""
    }
    
    static func reguesURL(path : String) -> String {
        return environment + path
    }
    
}
