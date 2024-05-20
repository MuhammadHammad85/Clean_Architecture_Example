//
//  MovieListUsecase.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation

typealias CBUserCaseMovieList = (_ result: [MovieLists]?,_ totalPages: Int?, _ errorMsg: String?) -> Void

protocol MovieListUseCaseProtocol {
    
    func execute(param: MovieListRequest , completion: @escaping CBUserCaseMovieList)
    
}

class MovieListUseCase: MovieListUseCaseProtocol {
    
    let repo: MoviesListRepoProtocol
    
    init(_repo: MoviesListRepoProtocol) {
        repo = _repo
    }
    
    func execute(param: MovieListRequest, completion: @escaping CBUserCaseMovieList) {
        repo.getMovies(param: param) { [weak self]
            response, message in
            guard let _ = self else { return }
            guard let response = response, let movies = response.result, let totalPages = response.totalPages else {
                completion(nil, nil, message)
                return
            }
            
            completion(movies, totalPages, nil)
        }
    }
}
