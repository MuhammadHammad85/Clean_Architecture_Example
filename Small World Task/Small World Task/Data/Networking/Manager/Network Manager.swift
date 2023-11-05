//
//  Network Manager.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation
import Alamofire

typealias CBService<T: Decodable> = (_ response: T?, _ error: NSError?) -> Void

class NetworkManager {
    
    static let instance: NetworkManager = {
        let instance = NetworkManager()
        return instance
    }()
    
    func requestService<T: Decodable, parameters: Encodable>( urlPath: String, method: HTTPMethod, parameters: parameters?, expectedResponse: T.Type = T.self, completion: @escaping CBService<T>) {
        
        var encoder: ParameterEncoder = URLEncodedFormParameterEncoder.default
        if method == .post {
            encoder = JSONParameterEncoder.default
        }
      
        AF.request(urlPath, method: method, parameters: parameters, encoder: encoder, headers: nil).responseDecodable(of: expectedResponse.self) { response in
           
            guard let code = response.response?.statusCode else {
                let error = NSError(domain: StaticStrings.Error, code: 10001)
                return completion(nil, error)
            }
            
            switch code {
            case 200...299:
                completion(response.value, nil)
            default:
                if let obj = response.value as? BaseResponse{
                    let error = NSError(domain: obj.message ?? StaticStrings.Error, code: 10002)
                    completion(nil, error)
                }else{
                    let error = NSError(domain:StaticStrings.connectivityIssue, code: 10003)
                    completion(nil, error)
                }
            }
        }
    }
}
    

