//
//  API Constant.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation

class APIConstant {
    
    static let instance: APIConstant = {
        let instance = APIConstant()
        return instance
    }()
    
    private let apiKey = "c9856d0cb57c3f14bf75bdc6c063b8f3"
    
    func getAPIKey()-> String{
        return apiKey
    }
}
