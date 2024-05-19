//
//  UserDefaultManager.swift
//  Small World Task
//
//  Created by Hammad Baig on 19/05/2024.
//

import Foundation

final class UserDefaultManager {
    
    class func set<T: Encodable>(value: T, key: String) {
        do {
            let encodedData = try JSONEncoder().encode(value)
            UserDefaults.standard.set(encodedData, forKey: key)
            UserDefaults.standard.synchronize()
        } catch {
            print("Failed to encode and store model: \(error)")
        }
    }
    
    class func get<T: Decodable>(key: String, type: T.Type) -> T? {
         guard let data = UserDefaults.standard.data(forKey: key) else { return nil }
        
        do {
            let decoded = try JSONDecoder().decode(T.self, from: data)
            return decoded
        } catch {
            print("Failed to Decode and store model: \(error)")
            return nil
        }
     }
     
     class func delete(key: String) {
         UserDefaults.standard.removeObject(forKey: key)
     }
}
