//
//  ClientStorage.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation

enum UserDefaultKeys: String{
    case MoviesResponse
}

final class ClientStorage {
    
    static let shared = ClientStorage()
    
    func save<T: Encodable>(_ value: T, as key: UserDefaultKeys) {
        UserDefaultManager.set(value: value, key: key.rawValue)
    }
    
    func delete(for key: UserDefaultKeys) {
        UserDefaultManager.delete(key: key.rawValue)
    }
    
    func get<T: Decodable>(for key: UserDefaultKeys, type: T.Type) -> T? {
        return UserDefaultManager.get(key: key.rawValue, type: type)
    }
    
    
}
