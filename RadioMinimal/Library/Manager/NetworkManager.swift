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
    case delete = "DELETE"
}

protocol EndPointProtocol {

    associatedtype Body: Decodable
    
    var base: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var body: Body? { get }
}

extension EndPointProtocol {
    var base: String {
        return "http://radiostations.gleeze.com:3000"
    }
}

protocol NetworkServiceProtocol {
    func request<GenericModel: Decodable>(point: StationsService, completion: @escaping (Result<GenericModel, Failure>) -> Void)
}

struct NetworkManager: NetworkServiceProtocol {
    
    func request<GenericModel: Decodable>(point: StationsService, completion: @escaping (Result<GenericModel, Failure>) -> Void) {
        
        guard let url = URL(string: "\(point.base)\(point.path)") else {
            debugPrint("<====  Failed to load data! ====>")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = point.method.rawValue
        request.cachePolicy = URLRequest.CachePolicy.reloadIgnoringLocalCacheData
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        if let data = point.body, let body = try? JSONEncoder().encode(data) {
            request.httpBody = body
        }
        
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

                guard let genericObject = try? JSONDecoder().decode(GenericModel.self, from: data) else {
                    completion(.failure(.decoding))
                    return
                }
                
                completion(.success(genericObject))
            }
            
        }.resume()
    }
}
