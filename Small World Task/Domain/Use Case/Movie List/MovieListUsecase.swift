//
//  MovieListUsecase.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation

typealias CBUserCaseMovieList = (_ totalPages: Int? ,_ movies: [MovieLists]?, _ errorMsg: String?) -> Void

protocol MovieListUseCaseProtocol {
    
    func execute(param: MovieListParam , completion: @escaping CBUserCaseMovieList)
    
}

class MovieListUserCase: MovieListUseCaseProtocol {
    
    private let movieListRepo: MoviesListRepoProtocol = MoviesRepository()
    
    
    func execute(param: MovieListParam, completion: @escaping CBUserCaseMovieList) {
        movieListRepo.getMovies(param: param) {
            response, error in
            if let response = response, let movies = response.result, let totalPages = response.totalPages {
                let storedList = ClientStorage.instance.getMoviesListResponse()?.result ?? []
                response.result = storedList + movies
                ClientStorage.instance.saveMoviesListResponse(response)
                completion(totalPages,movies, nil)
            }else{
                completion(nil, nil, error?.domain)
            }
        }
    }
}
