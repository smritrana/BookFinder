//
//  BookUseCase.swift
//  BookFinder
//
//  Created by Smriti Rana on 14/12/22.
//

import Foundation

typealias DomainResponse = (Result<BookInfo, Error>) -> Void

protocol BookUseCaseProtocol {
    func fetchBookList(_ searchItem: String, completion: @escaping DomainResponse)
}

class BookUseCase: BookUseCaseProtocol {
        
    private let respository: BookRepositoryProtocol
    
    init(respository: BookRepositoryProtocol) {
        self.respository = respository
    }
    
    func fetchBookList(_ searchItem: String, completion: @escaping DomainResponse) {
        return self.respository.fetchBookList(searchItem) { (result: Result<BookDomainListDTO, Error>) in
            switch result {
            case .success(let books):
                completion(.success(books.toPresentation() ))
            case .failure(_):
                completion(.failure(NetworkError.failed))
            }
        }
    }
}
