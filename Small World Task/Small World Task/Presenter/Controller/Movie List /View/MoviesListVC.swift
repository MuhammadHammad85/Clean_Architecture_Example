//
//  MoviesListVC.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import UIKit

class MoviesListVC: BaseVC {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    private var viewModal = MoviesListViewModal()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews(){
        viewModal.delegate = self
        setNavTitle()
        setupSearchBar()
        registerCell()
        fetchMovies()
    }
    
    private func fetchMovies(){
        viewModal.fetchMovies()
    }
    
    private func setNavTitle(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = viewModal.navTitle
    }
    
    private func setupSearchBar(){
        searchBar.placeholder = viewModal.searchBarPlaceHolder
        searchBar.delegate = self
        searchBar.showsCancelButton = true
    }

    private func registerCell(){
        tableView.registerCell(name: MovieListTableViewCell.name)
        tableView.delegate = self
        tableView.dataSource = self
    }

}

//MARK: - UITableViewDelegate & UITableViewDataSource
extension MoviesListVC: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModal.getMovieCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MovieListTableViewCell.getIdentifier(), for: indexPath) as? MovieListTableViewCell else {  return UITableViewCell()  }
        let data = viewModal.getMovie(at: indexPath.row)
        cell.configureCell(data)
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let id = viewModal.getMovie(at: indexPath.row).id ?? 0
        navigateToDetail(with: id)
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        viewModal.applyPagination(at: indexPath.row)
    }
}

//MARK: - UISearchBar Delegate
extension MoviesListVC: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModal.applySearch(with: searchText)
    }

    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
    }

    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        viewModal.clearSearch()
    }
    
}

//MARK: - Navigations
extension MoviesListVC {
    
    private func navigateToDetail(with movieId: Int){
        let dVC = StoryBoards.main.instantiateViewController(withIdentifier: MovieDetailVC.getIdentifier())as! MovieDetailVC
        let viewModal = MovieDetailViewModal(movieId: movieId)
        dVC.viewModel = viewModal
        self.navigationController?.pushViewController(dVC, animated: true)
    }

}

//MARK: - MoviesListViewModal
extension MoviesListVC: MoviesListViewModalDelegate, Alertable {
    
    func onSucces() {
        tableView.reloadData()
    }
    
    func show(_ message: String) {
        showAlert(message: message)
    }
    
    func searchState(active: Bool) {
        if !active {
            searchBar.endEditing(active)
        }
        
        tableView.reloadData()
    }
}
