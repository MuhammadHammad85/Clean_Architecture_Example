//
//  MovieListTableViewCell.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import UIKit

class MovieListTableViewCell: UITableViewCell, IdentifiableProtocol {

    @IBOutlet weak var imageViewMovie: UIImageView!
    @IBOutlet weak var labelName: UILabel!
    @IBOutlet weak var labelReleaseDate: UILabel!
    
    
    func configureCell(_ movie: MovieLists?){
        setupViews()
        guard let movie = movie else{ return }
        setMovieInfo(movie)
    }
    
    private func setupViews(){
        imageViewMovie.layer.cornerRadius = 10
        imageViewMovie.clipsToBounds = true
    }
    
    private func setMovieInfo(_ movie: MovieLists){
        setMedia(with:  movie.posterPath ?? "", at: imageViewMovie)
        labelName.text = movie.title ?? ""
        labelReleaseDate.text = movie.releaseDate ?? ""
    }
}
