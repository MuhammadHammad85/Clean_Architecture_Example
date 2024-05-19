//
//  MovieDetailUsecase.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation

typealias CBUserCaseMovieDetail = (_ movie: MovieDetailResponse?, _ errorMsg: String?) -> Void

protocol MovieDetailUseCaseProtocol {
    
    func execute(with id:Int, param: MovieDetailRequest, completion: @escaping CBUserCaseMovieDetail)
    
}

class MovieDetailUserCase: MovieDetailUseCaseProtocol {
    
    private let movieListRepo: MovieDetailRepoProtocol = MoviesRepository()
    
    
    func execute(with id:Int, param: MovieDetailRequest, completion: @escaping CBUserCaseMovieDetail) {
        movieListRepo.getMovieDetail(with: id, param: param) {
            movie, error in
            if let movie = movie {
                completion(movie, nil)
            }else{
                completion( nil, error?.domain)
            }
        }
    }
}
