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

class MoviesListViewModal: BaseViewModal {
    
    let navTitle: String = "Movies List"
    let searchBarPlaceHolder = "Search movies"
    var delegate: MoviesListViewModalDelegate?
    private let useCase: MovieListUseCaseProtocol = MovieListUserCase()
    private var moviesList:  [MovieLists] = []
    private var searchedMovies: [MovieLists] = []
    private var totatPages: Int = 0
    var isActiveSearch = false
    var currentPage: Int = 1
    
    func getMovie(at index: Int)-> MovieLists{
        if isActiveSearch {
            return searchedMovies[index]
        }else{
            return moviesList[index]
        }
    }
    
    func getMovieCount()-> Int{
        if isActiveSearch {
            return searchedMovies.count
        }else{
            return moviesList.count
        }
    }
    
    func applyPagination(at index: Int){
        if !isActiveSearch {
            if index == (getMovieCount() - 1){
                if currentPage != totatPages {
                    currentPage += 1
                    fetchMovies()
                }
            }
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
    
    func loadStoredData(){
        let data = ClientStorage.instance.getMoviesListResponse()
        self.totatPages = data?.totalPages ?? 0
        self.currentPage = data?.page ?? 1
        moviesList = data?.result ?? []
    }
}

//MARK: - API Calling
extension MoviesListViewModal {
    
    ///Fetch Movies
    func fetchMovies(){
        if Reachable.instance.isReachable() {
            let apiKey = APIConstant.instance.getAPIKey()
            let param = MovieListRequest(apiKey:apiKey, page: self.currentPage)
            useCase.execute(param: param) { [weak self]
                totalPages , movies, errorMsg in
                guard let self = self else { return }
                if let movies = movies , let totalPages = totalPages {
                    defer { self.delegate?.onSucces() }
                    self.totatPages = totalPages
                    for movie in movies {
                        self.moviesList.append(movie)
                    }
                }else{
                    self.delegate?.show(errorMsg ?? StaticStrings.SomethingWentWrong)
                }
            }
        }else{
            loadStoredData()
            self.delegate?.show(StaticStrings.noInternetConnection)
        }
        
    }
    
}
