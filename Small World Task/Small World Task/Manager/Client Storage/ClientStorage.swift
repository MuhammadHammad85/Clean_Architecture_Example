//
//  ClientStorage.swift
//  Small World Task
//
//  Created by Hammad Baig on 04/11/2023.
//

import Foundation

class ClientStorage {
    
    static let instance = {
        let instance = ClientStorage()
        return instance
    }()
    
    //MARK: - Movie List
    func saveMoviesListResponse(_ data: MovieListResponse){
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(data)
            print("Saved Movie List Response")
            UserDefaults.standard.set(encodedData, forKey: "MovieListResponse")
        } catch {
            fatalError("Can't save Movie List Response")
        }
    }
   
    func getMoviesListResponse()-> MovieListResponse?{
        if UserDefaults.standard.object(forKey: "MovieListResponse") != nil {
            if let data = UserDefaults.standard.value(forKey: "MovieListResponse") as? Data {
                let decoder = JSONDecoder()
                let data = try? decoder.decode(MovieListResponse.self, from: data)
                return data!
            }
        }
        return nil
    }
    
    func deleteMoviesListResponse(){
        UserDefaults.standard.set(nil, forKey: "MovieListResponse")
    }
    
}
