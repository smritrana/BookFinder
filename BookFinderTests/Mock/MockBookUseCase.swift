//
//  MockBookUseCase.swift
//  BookFinderTests
//
//  Created by Smriti Rana on 17/12/22.
//

import XCTest

@testable import BookFinder

class MockBookUseCase: BookUseCaseProtocol {
    var bookInfo: BookInfo?
    var error: Error?
    
    func fetchBookList(_ searchItem: String, completion: @escaping DomainResponse) {
        if let error = error {
            return completion(.failure(error))
        }
        if let bookInfo = bookInfo {
            return completion(.success(bookInfo))
        }
    }
}
