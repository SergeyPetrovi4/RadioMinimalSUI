//
//  NetworkManager.swift
//  RadioMinimal
//
//  Created by Sergey Krasiuk on 15/12/2020.
//

import Foundation

enum Failure: Error {
    
    case error(String)
    case serialization
    case decoding
    case unknown
}

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
}

enum API: String {
    case stations = "http://radiostations.gleeze.com:3000/stations/"
}

protocol NetworkServiceProtocol {
    func request<GenericData: Decodable>(url: API, method: HTTPMethod, model: GenericData.Type, completion: @escaping (Result<GenericData, Failure>) -> Void)
}

struct NetworkManager: NetworkServiceProtocol {
    
    func request<GenericData: Decodable>(url: API, method: HTTPMethod, model: GenericData.Type, completion: @escaping (Result<GenericData, Failure>) -> Void) {
        
        guard let url = URL(string: url.rawValue) else {
            debugPrint("<====  Failed to load data! ====>")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            DispatchQueue.main.async {
                if let errorResponse = error {
                    completion(.failure(.error(errorResponse.localizedDescription)))
                }
                
                guard let data = data else {
                    debugPrint(error?.localizedDescription ?? "[Response] Something wrong with response!!!")
                    completion(.failure(.serialization))
                    return
                }

                guard let genericObject = try? JSONDecoder().decode(GenericData.self, from: data) else {
                    completion(.failure(.decoding))
                    return
                }
                
                completion(.success(genericObject))
            }
            
        }.resume()
    }
}
