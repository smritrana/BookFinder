//
//  BooksListViewModel.swift
//  BookFinder
//
//  Created by Smriti Rana on 13/12/22.
//

import UIKit

protocol BookListInputViewModel {
    var bookInfo: [BookViewModelMapper] { get set }
    func fetchResults(_ searchedTerm: String)
    var getScreenName: String {get}
}

protocol BookListOutputViewModel {
    var loadTable: Dynamic<Bool> { get }
    var showHint: Dynamic<Bool> { get }
    var showLoader: Dynamic<Bool> { get }
    var stopLoader: Dynamic<Bool> { get }

    func handleFailure()
}

protocol BookListViewModelType {
    var output: BookListOutputViewModel { get }
    var input: BookListInputViewModel { get }
}

class BookListViewModel: NSObject {
    var loadTable: Dynamic<Bool> = Dynamic(false)
    var showHint: Dynamic<Bool> = Dynamic(false)
    var showLoader: Dynamic<Bool> = Dynamic(false)
    var stopLoader: Dynamic<Bool> = Dynamic(false)

    let minimiumSearchTextLength = 2
    let apiLatency = 0.5
    var bookInfo: [BookViewModelMapper] = [BookViewModelMapper]()
    var searchItem = ""
    private let useCase: BookUseCaseProtocol
    init(useCase: BookUseCaseProtocol) {
        self.useCase = useCase
    }
}

extension BookListViewModel: BookListInputViewModel, BookListViewModelType  {
    var input: BookListInputViewModel { return self }
    
    var getScreenName: String {
        return "Book Finder"
    }
    
    func fetchResults(_ searchedTerm: String) {
        showLoader.value = !showLoader.value
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector:  #selector(fetchResultsFromAPI), object: nil)

        // Check minumum characters for search
        if searchedTerm.count < minimiumSearchTextLength {
            self.bookInfo.removeAll()
            self.reloadTableView()
            self.reloadHintView()
            return
        }
        searchItem = searchedTerm
        self.perform(#selector(fetchResultsFromAPI), with:nil, afterDelay: apiLatency)
    }
    
    @objc private func fetchResultsFromAPI() {
        self.useCase.fetchBookList(searchItem) { [weak self] result  in
            switch result {
            case let .success(books):
                if let bookCounts = self?.bookInfo, bookCounts.isEmpty {
                    self?.reloadHintView()
                }
                if let obj = self?.processFetched(books) {
                    self?.bookInfo = obj
                }
                self?.reloadTableView()
            case .failure(_):
                self?.stopLoaderIndicator()
                self?.handleFailure()
            }
        }
    }
    
    private func stopLoaderIndicator() {
        stopLoader.value = !stopLoader.value
    }
    
    private func reloadTableView() {
        stopLoader.value = !stopLoader.value
        loadTable.value = !loadTable.value
    }
    
    private func reloadHintView() {
        stopLoader.value = !stopLoader.value
        showHint.value = !showHint.value
    }
    
    private func processFetched(_ bookInfo: BookInfo) -> [BookViewModelMapper] {
        var cellViewModel = [BookViewModelMapper]()
        for item in bookInfo.items {
            let itemInfo = item.volumeInfo
            let obj = BookViewModelMapper(title: itemInfo.title,
                                          subTitle: itemInfo.subtitle ?? "",
                                          imageUrl: itemInfo.imageLinks.smallThumbnail)
                cellViewModel.append(obj)
        }
        return cellViewModel
    }
}

extension BookListViewModel: BookListOutputViewModel {
    var output: BookListOutputViewModel { return self }

    func handleFailure() {
        //Handle failure
    }
}
