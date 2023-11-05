//
//  BaseResponse.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation

protocol BaseResponse {
    
    var code: Int? { get set }
    var message: String? { get set }
    var succes: Bool? { get set }
    
}
