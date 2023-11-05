//
//  Common Function.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation
import SDWebImage

func setMedia(with endPoint: String, at view: UIImageView ,placeHolderImage: UIImage? = nil){
    let url = MediaURL.reguesURL(path: endPoint)
    let urlString = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
    view.sd_imageIndicator = SDWebImageActivityIndicator.gray
    view.sd_setImage(with: URL(string: urlString), placeholderImage: placeHolderImage)
}
