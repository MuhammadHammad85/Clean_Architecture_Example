//
//  MoviesListViewModal.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation

protocol MoviesListViewModalDelegate: BaseViewModalProtocol{
    func onSucces()
    func searchState(active: Bool)
}

class MoviesListViewModal  {
    
    let navTitle: String = "Movies List"
    let searchBarPlaceHolder = "Search movies"
    weak var delegate: MoviesListViewModalDelegate?
    private let useCase: MovieListUseCaseProtocol
    private var moviesList:  [MovieLists] = []
    private var searchedMovies: [MovieLists] = []
    private var totalPages: Int = 0
    var isActiveSearch = false
    var currentPage: Int = 1
    
    init(_delegate: MoviesListViewModalDelegate, _useCase: MovieListUseCaseProtocol ) {
        delegate = _delegate
        useCase = _useCase
        fetchMovies(for: currentPage)
    }
    
    func getMovie(at index: Int)-> MovieLists{
        return isActiveSearch ? searchedMovies[index] : moviesList[index]
    }
    
    func getMovieCount()-> Int{
        return isActiveSearch ? searchedMovies.count : moviesList.count
    }
    
    func applyPagination(at index: Int){
        if !isActiveSearch && index == (getMovieCount() - 1) && currentPage != totalPages{
            currentPage += 1
            fetchMovies(for: currentPage)
        }
    }
    
    func applySearch(with text: String){
        if text.isEmpty {
            clearSearch()
        }else{
            isActiveSearch = true
            searchedMovies = moviesList.filter({
                (data: MovieLists) -> Bool in
                guard let name = data.title else { return false }
                return name.range(of: text, options: .caseInsensitive) != nil})

            delegate?.searchState(active: true)
        }
      
    }
    
    func clearSearch(){
        isActiveSearch = false
        searchedMovies.removeAll()
        delegate?.searchState(active: false)
    }
}

//MARK: - API Calling
extension MoviesListViewModal {
    
    ///Fetch Movies
    private func fetchMovies( for page: Int){
        let apiKey = APIConstant.instance.getAPIKey()
        let param = MovieListRequest(apiKey:apiKey, page: page)
        
        useCase.execute(param: param) { [ weak self ]
            movies, _totalPages, message in
            guard let self = self else{ return }
            if let movies = movies, let _totalPages = _totalPages {
                
                defer { delegate?.onSucces() }
               
                moviesList += movies
                totalPages = _totalPages
            
            }else{
                delegate?.show(message ?? StaticStrings.SomethingWentWrong)
            }
        }
    }
    
}
