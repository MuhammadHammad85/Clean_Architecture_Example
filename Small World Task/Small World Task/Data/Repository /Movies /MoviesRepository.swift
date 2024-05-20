//
//  MoviesRepository.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation

typealias CBRepoMovieList = (_ response: MovieListResponse?, _ message: String?) -> Void
typealias CBRepoMovieDetail = (_ response: MovieDetailResponse?, _ message: String?) -> Void

protocol MoviesListRepoProtocol {
    func getMovies( param: MovieListRequest, completion: @escaping CBRepoMovieList)
}

protocol MovieDetailRepoProtocol {
    func getMovieDetail(with id: Int, param: MovieDetailRequest, completion: @escaping CBRepoMovieDetail)
}

class MoviesRepository: MoviesListRepoProtocol, MovieDetailRepoProtocol {
    
    let networkManager: NetworkManagerProtocol
    
    init(request: NetworkManagerProtocol ){
        networkManager = request
    }
    
    //MARK: - Fetch Movies List
    func getMovies(param: MovieListRequest, completion: @escaping CBRepoMovieList) {
        networkManager.requestService(
            urlPath: AppURL.reguesURL(path: Path.discoverMovies),
            method: .get,
            parameters: param,
            expectedResponse: MovieListResponse.self
            ,completion: { [weak self]
                (response, error) in
                guard let _ = self else { return }
                if let response = response {
                    completion(response, nil)
                }else {
                    completion(nil, error?.domain)
                }
            }
        )
    }
    
    //MARK: - Fetch Movie Detail
    func getMovieDetail(with id: Int,param: MovieDetailRequest, completion: @escaping CBRepoMovieDetail) {
        networkManager.requestService(
            urlPath: AppURL.reguesURL(path: Path.getDetails(id)),
            method: .get,
            parameters: param,
            expectedResponse: MovieDetailResponse.self
            ,completion: { [weak self]
                (response, error) in
                guard let _ = self else { return }
                if let response = response {
                    completion(response, nil)
                }else {
                    completion(nil, error?.domain)
                }
            }
        )
    }
    
}
