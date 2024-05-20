//
//  MovieDetailUsecase.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation

typealias CBUserCaseMovieDetail = (_ movieDetail: MovieDetailResponse?, _ errorMsg: String?) -> Void

protocol MovieDetailUseCaseProtocol {
    
    func execute(with id:Int, param: MovieDetailRequest, completion: @escaping CBUserCaseMovieDetail)
    
}

class MovieDetailUseCase: MovieDetailUseCaseProtocol {
    
    let repo: MovieDetailRepoProtocol
    
    init(_repo: MovieDetailRepoProtocol ){
        repo = _repo
    }
    
    func execute(with id:Int, param: MovieDetailRequest, completion: @escaping CBUserCaseMovieDetail) {
        
        repo.getMovieDetail(with: id, param: param) { [ weak self ]
            movieDetail, message in
            guard let _ = self else { return }
            if let movieDetail = movieDetail {
                completion(movieDetail, nil)
            }else{
                completion(nil, message)
            }
        }
    }
}
