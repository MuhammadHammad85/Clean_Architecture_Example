//
//  MovieDetailViewModal.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation

protocol MovieDetailViewModalDelegate: BaseViewModalProtocol {
    func onSuccessMovieDetail()
}

class MovieDetailViewModal: BaseViewModal {
    
    var movieId: Int?
    let title = "Movie Detail"
    private let useCase: MovieDetailUseCaseProtocol = MovieDetailUserCase()
    private var movieInfo: MovieDetailResponse?
    var delegate: MovieDetailViewModalDelegate?
    
    init(movieId id: Int) {
        self.movieId = id
    }
    
    func getMovieName()-> String{
        return movieInfo?.title ?? ""
    }
    
    func getMovieDesciption()-> String{
        return movieInfo?.description ?? ""
    }
    
    func getMoviePoster()-> String {
        return movieInfo?.posterImage ?? ""
    }
    
    private func getStoredMovieInfo(){
        let data = ClientStorage.instance.getMoviesListResponse()?.result ?? []
        guard let movie = data.first(where: { $0.id == movieId }) else {return}
        movieInfo = MovieDetailResponse(
            id: movie.id,
            title: movie.title,
            description: movie.description,
            releaseDate: movie.releaseDate,
            posterImage: movie.posterPath)
    }
}
//MARK: - API Calling
extension MovieDetailViewModal {
    
    ///Fetch Movie Detail
    func fetchMovieDetail(){
        if Reachable.instance.isReachable() {
            let apiKey = APIConstant.instance.getAPIKey()
            let param = MovieDetailParam(apiKey:apiKey)
            guard let movieId = movieId else{ return }
            
            useCase.execute(with: movieId , param: param) { [weak self]
                movie, errorMsg in
                guard let self = self else { return }
                if let movie = movie {
                    defer { self.delegate?.onSuccessMovieDetail() }
                    
                    self.movieInfo = movie
                }else{
                    self.delegate?.show(errorMsg ?? StaticStrings.SomethingWentWrong)
                }
            }
        }else{
            getStoredMovieInfo()
            delegate?.onSuccessMovieDetail()
            delegate?.show(StaticStrings.noInternetConnection)
        }
        
    }
    
}
