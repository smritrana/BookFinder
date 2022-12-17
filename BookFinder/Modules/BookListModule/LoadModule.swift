//
//  LoadModule.swift
//  BookFinder
//
//  Created by Smriti Rana on 13/12/22.
//
import Foundation
import UIKit

class LoadModule {

    enum Constants {
        static let identifier = "BookListViewController"
    }
    
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol) {
        self.networkManager = networkManager
    }

    func generateViewController() -> UIViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: Constants.identifier) as? BookListViewController  else {
            fatalError()
        }
        viewController.viewModel = BookListViewModel(useCase:  createBookUseCase())
        return viewController
    }
    
    private func createBookUseCase() -> BookUseCaseProtocol {
        let useCase = BookUseCase(respository: createRepository())
        return useCase
    }

    private func createRepository() -> BookRepositoryProtocol {
        let repository = BookRepository(service: createService())
        return repository
    }
    
    private func createService() -> BookServiceProtocol {
        let service = BookService(networkManager: networkManager)
        return service
    }
}
