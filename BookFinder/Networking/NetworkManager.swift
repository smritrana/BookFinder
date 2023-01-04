//
//  NetworkManager.swift
//  BookFinder
//
//  Created by Smriti Rana on 13/12/22.
//

import Foundation

typealias Response<T: Decodable> = (Result<T, Error>) -> Void

protocol NetworkManagerProtocol {
    func request<T: Decodable>(request: NetworkRequestProtocol, completion: @escaping Response<T>)
}

class NetworkManager: NetworkManagerProtocol {
    
    private let session: URLSession
    private let requestGenerator: URLRequestGeneratorProtocol
    
    init(session: URLSession, requestGenerator: URLRequestGeneratorProtocol) {
        self.session = session
        self.requestGenerator = requestGenerator
    }
    
    convenience init(session: URLSession = .shared) {
        self.init(session: session, requestGenerator: URLRequestGenerator())
    }
    
    func request<T: Decodable>(request: NetworkRequestProtocol, completion: @escaping Response<T>) {
        
        guard let urlRequest = try? requestGenerator.createURLRequest(using: request) else {
            completion(.failure(NetworkError.invalidRequest))
            return
        }

        let task = session.dataTask(with: urlRequest) { data, response, error in

            if error != nil {
                completion(.failure(NetworkError.badRequest))
            }
            
            guard let urlResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.noResponse))
                return
            }
            
            if urlResponse.statusCode != 200 {
                completion(.failure(NetworkError.failed))
            }
            
            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch {
                completion(.failure(NetworkError.unableToDecode))
            }
        }
        task.resume()
    }
}
