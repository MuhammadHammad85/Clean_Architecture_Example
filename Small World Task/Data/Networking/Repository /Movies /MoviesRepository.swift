//
//  MoviesRepository.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation

typealias CBRepoMovieList = (_ response: MovieListResponse?, _ error: NSError?) -> Void
typealias CBRepoMovieDetail = (_ response: MovieDetailResponse?, _ error: NSError?) -> Void

protocol MoviesListRepoProtocol {
    func getMovies( param: MovieListParam, completion: @escaping CBRepoMovieList)
}

protocol MovieDetailRepoProtocol {
    func getMovieDetail(with id: Int, param: MovieDetailParam, completion: @escaping CBRepoMovieDetail)
}

class MoviesRepository: MoviesListRepoProtocol,  MovieDetailRepoProtocol {
    
    
    
    //MARK: - Fetch Movies List
    func getMovies(param: MovieListParam, completion: @escaping CBRepoMovieList) {
        NetworkManager.instance.requestService(
            urlPath: AppURL.reguesURL(path: Path.discoverMovies),
            method: .get,
            parameters: param,
            expectedResponse: MovieListResponse.self
            ,completion: {
                (response, error) in
                if response != nil {
                    completion(response, nil)
                } else {
                    completion(nil, error)
                }
            }
        )
    }
    
    //MARK: - Fetch Movie Detail
    func getMovieDetail(with id: Int,param: MovieDetailParam, completion: @escaping CBRepoMovieDetail) {
        NetworkManager.instance.requestService(
            urlPath: AppURL.reguesURL(path: Path.getDetails(id)),
            method: .get,
            parameters: param,
            expectedResponse: MovieDetailResponse.self
            ,completion: {
                (response, error) in
                if response != nil {
                    completion(response, nil)
                } else {
                    completion(nil, error)
                }
            }
        )
    }

}
