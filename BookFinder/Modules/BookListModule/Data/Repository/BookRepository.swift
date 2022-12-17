//
//  BookRepository.swift
//  BookFinder
//
//  Created by Smriti Rana on 13/12/22.
//

import Foundation

typealias DataResponse = (Result<BookDomainListDTO, Error>) -> Void

protocol BookRepositoryProtocol {
    func fetchBookList(_ searchItem: String, completion: @escaping DataResponse)
}

class BookRepository: BookRepositoryProtocol {
        
    private let service: BookServiceProtocol
    
    init(service: BookServiceProtocol) {
        self.service = service
    }
    
    func fetchBookList(_ searchItem: String, completion: @escaping DataResponse) {
        self.service.fetchBooksFromNetwork(searchItem) {
            (result: Result<BookDataListDTO, Error>) in
                switch result {
                case .success(let books):
                    completion(.success(books.toDmoain()))
                case .failure(_):
                    completion(.failure(NetworkError.failed))
                }
        }
    }
}
