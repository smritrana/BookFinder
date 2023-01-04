//
//  MockBookRepository.swift
//  BookFinderTests
//
//  Created by Smriti Rana on 17/12/22.
//

import XCTest

@testable import BookFinder

class MockBookRepository: BookRepositoryProtocol {
    
    var bookInfo: BookDomainListDTO?
    var error: Error?
    
    func fetchBookList(_ searchItem: String, completion: @escaping DataResponse) {
        if let error = error {
            completion(.failure(error))
        }
        if let bookInfo = bookInfo {
            completion(.success(bookInfo))
        }
    }
}
