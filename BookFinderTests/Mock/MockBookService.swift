//
//  MockBookService.swift
//  BookFinderTests
//
//  Created by Smriti Rana on 17/12/22.
//

import Foundation
@testable import BookFinder

class MockBookService: BookServiceProtocol {
    var response: BookDataListDTO?
    var error: Error?
    
    func fetchBooksFromNetwork(_ searchItem: String, completion: @escaping (Result<BookDataListDTO, Error>) -> Void) {
        if let error = error {
            return completion(.failure(error))
        }
        if let response = response {
            return completion(.success(response))
        }
    }
}
