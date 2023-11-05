//
//  MovieDetailVC.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import UIKit

class MovieDetailVC: BaseVC {

    @IBOutlet weak var imageViewMoview: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var viewSuper: UIView!
    
    var viewModel: MovieDetailViewModal?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    private func setupViews(){
        viewModel?.delegate = self
        setNavBar()
        setupUIViews()
        fetchDetail()
    }
    
    private func setNavBar(){
        self.navigationController?.navigationBar.prefersLargeTitles = true
        title = viewModel?.title
    }
    
    private func setupUIViews(){
        viewSuper.isHidden = true
        imageViewMoview.layer.cornerRadius = 10
    }
    
    private func fetchDetail(){
        viewModel?.fetchMovieDetail()
    }

    private func loadData(){
        labelName.text = viewModel?.getMovieName()
        labelDescription.text = viewModel?.getMovieDesciption()
        let poster = viewModel?.getMoviePoster() ?? ""
        setMedia(with: poster , at: imageViewMoview)
        viewSuper.isHidden = false
    }
}
//MARK: - MovieDetailViewModalDelegate, Alertable
extension MovieDetailVC: MovieDetailViewModalDelegate, Alertable {
    
    func onSuccessMovieDetail() {
        loadData()
    }
    
    func show(_ message: String) {
        showAlert(message: message)
    }
}
