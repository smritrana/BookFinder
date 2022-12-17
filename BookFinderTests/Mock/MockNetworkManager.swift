//
//  MockNetworkManager.swift
//  BookFinderTests
//
//  Created by Smriti Rana on 17/12/22.
//

import Foundation
@testable import BookFinder

class MockNetworkManager: NetworkManagerProtocol {

    var response: Decodable?
    var error: Error?
    
    func request<T: Decodable>(request: NetworkRequestProtocol, completion: @escaping Response<T>) {
        if let error = error {
            return completion(.failure(error))
        }
        if let resposne = response {
            completion(.success(resposne as! T))
        }
    }
}
