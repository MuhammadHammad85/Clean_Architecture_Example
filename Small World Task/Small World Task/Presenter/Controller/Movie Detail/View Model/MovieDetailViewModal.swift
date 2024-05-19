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

class MovieDetailViewModal  {
    
    let title = "Movie Detail"
    private var movieInfo: MovieDetailResponse?
    weak var delegate: MovieDetailViewModalDelegate?
    private let useCase: MovieDetailUseCaseProtocol
    
    init(movieId id: Int, _delegate: MovieDetailViewModalDelegate, _useCase: MovieDetailUseCaseProtocol ) {
        delegate = _delegate
        useCase = _useCase
        fetchMovieDetail(movieId: id)
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

}
//MARK: - API Calling
extension MovieDetailViewModal {
    
    ///Fetch Movie Detail
    private func fetchMovieDetail(movieId: Int){
        let apiKey = APIConstant.instance.getAPIKey()
        let param = MovieDetailRequest(apiKey:apiKey)
        useCase.execute(with: movieId , param: param) { [weak self]
            _movieInfo, message in
          
            guard let self = self else { return }
            
            if let _movieInfo = _movieInfo {
                
                defer { delegate?.onSuccessMovieDetail() }
                movieInfo = _movieInfo
                
            }else{
                delegate?.show(message ?? StaticStrings.SomethingWentWrong)
            }
            
        }
    }
    
}
