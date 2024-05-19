//
//  Network Manager.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation
import Alamofire

typealias CBService<T: Decodable> = (_ response: T?, _ error: NSError?) -> Void

protocol NetworkManagerProtocol {
    func requestService<T: Decodable, parameters: Encodable>( urlPath: String, method: HTTPMethod, parameters: parameters?, expectedResponse: T.Type , completion: @escaping CBService<T>)
}

class NetworkManager: NetworkManagerProtocol {
    
    
    func requestService<T: Decodable, parameters: Encodable>( urlPath: String, method: HTTPMethod, parameters: parameters?, expectedResponse: T.Type, completion: @escaping CBService<T>) {
        
        guard Reachable().isReachable() else{
            /// NSURLErrorNotConnectedToInternet = -1009
            completion(nil, NSError(domain: StaticStrings.noInternetConnection, code: NSURLErrorNotConnectedToInternet))
            return
        }
        
        var encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default
        if method == .post {
            encoder = JSONParameterEncoder.default
        }
      
        AF.request(urlPath, method: method, parameters: parameters, encoder: encoder, headers: nil).responseDecodable(of: expectedResponse.self) { response in
           
            guard let code = response.response?.statusCode else {
                let nsError = NSError(domain: StaticStrings.noInternetConnection, code: response.error?.responseCode ?? NSURLErrorUnknown)
                return completion(nil, nsError)
            }
            
            switch code {
            case 200...299:
                completion(response.value, nil)
            default:
                if let obj = response.value as? BaseResponse{
                    let error = NSError(domain: obj.message ?? StaticStrings.unableDecodeMessage, code: code)
                    completion(nil, error)
                }else{
                    let error = NSError(domain:StaticStrings.unableDecodeMessage, code: code)
                    completion(nil, error)
                }
            }
        }
    }
}
    

