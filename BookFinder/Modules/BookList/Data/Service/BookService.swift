//
//  BookService.swift
//  BookFinder
//
//  Created by Smriti Rana on 13/12/22.
//
import Foundation

protocol BookServiceProtocol {
    func fetchBooksFromNetwork(_ searchItem: String, completion: @escaping (Result<BookDataListDTO, Error>) -> Void)
}

class BookService: BookServiceProtocol {
        
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func fetchBooksFromNetwork(_ searchItem: String, completion: @escaping (Result<BookDataListDTO, Error>) -> Void) {
        let request = NetworkRequest(path: APIPathUrl.findBookUrl,
                                     method: .get,
                                     queryParameters: ["q":searchItem,
                                                       "key": Configuration.apiKey]
        )
        self.networkManager.request(request: request, completion: completion)
    }
}
