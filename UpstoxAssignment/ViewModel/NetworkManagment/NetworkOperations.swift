//
//  NetworkOperations.swift
//  UpstoxAssignment
//
//  Created by Arrax on 17/02/24.
//

import Foundation

class NetworkOperations : ObservableObject {
    
    //MARK: Singeleton class for specific usage only
    static let shared :  NetworkOperations = NetworkOperations()
    
    private init () {}
    
    //MARK: Generic function for all API calls
    func fetchDataFromAPI<T : Codable> (url :String, model : T.Type, completion : @escaping(Result<T, Error>) -> Void) {
        
        guard let url = URL(string: url) else { return }
        
        let URLReq = URLRequest(url: url)
        
        let dataTask = URLSession.shared.dataTask(with: URLReq) { (data, _ ,error) in
            if let error = error { completion(.failure(error))}
            
            guard let data = data else { return }
            
            let decoder = JSONDecoder()
            
            do {
                let decodedData = try decoder.decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
}
