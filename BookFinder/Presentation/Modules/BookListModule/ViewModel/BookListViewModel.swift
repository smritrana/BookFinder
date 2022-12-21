//
//  BooksListViewModel.swift
//  BookFinder
//
//  Created by Smriti Rana on 13/12/22.
//

import UIKit

private struct ConstantValues {
   static let listScreenName = "Book Finder"
   static let alertTitle = "Alert!"
   static let alertMessage = "No book available"
}

protocol BookListInputViewModel {
    func fetchResults(_ searchedTerm: String)
}

protocol BookListOutputViewModel {
    var loadTable: Dynamic<Bool> { get }
    var showHint: Dynamic<Bool> { get }
    var showLoader: Dynamic<Bool> { get }
    var stopLoader: Dynamic<Bool> { get }
    var showAlert: Dynamic<Bool> { get }

    var getScreenName: String {get}
    var getAlertMessage: (title: String, message: String) {get}
    var bookInfo: [BookViewModelMapper] {get}

    func handleFailure()
}

protocol BookListViewModelType {
    var output: BookListOutputViewModel { get }
    var input: BookListInputViewModel { get }
}

final class BookListViewModel: BookListViewModelType, BookListInputViewModel {
    var loadTable: Dynamic<Bool> = Dynamic(false)
    var showHint: Dynamic<Bool> = Dynamic(false)
    var showLoader: Dynamic<Bool> = Dynamic(false)
    var stopLoader: Dynamic<Bool> = Dynamic(false)
    var showAlert: Dynamic<Bool> = Dynamic(false)

    private lazy var bookInfoMapper: [BookViewModelMapper] = []
    private let minimiumSearchTextLength = 2
    private let apiLatency = 0.5
    private var searchValue: String?
    private let useCase: BookUseCaseProtocol
    private var requestTimer: Timer?

    init(useCase: BookUseCaseProtocol) {
        self.useCase = useCase
    }

    var input: BookListInputViewModel { return self }
    /// Mapper class for list Item Cell
    var bookInfo: [BookViewModelMapper] {
        return bookInfoMapper
    }

    // Get Screen Name from constant
    var getScreenName: String {
        return ConstantValues.listScreenName
    }

    /// Get Alert Message: title and subTitle
    var getAlertMessage: (title: String,
                          message: String) {
        return (ConstantValues.alertTitle,
                ConstantValues.alertMessage)
    }

    /// fetch Results
    /// - Parameter searchedTerm: String
    func fetchResults(_ searchedTerm: String) {
        showLoader.value = !showLoader.value
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector:  #selector(fetchResultsFromAPI), object: nil)
        self.searchValue = searchedTerm
        if searchedTerm.count < minimiumSearchTextLength {
            self.bookInfoMapper.removeAll()
            self.reloadTableView()
            self.reloadHintView()
            return
        }
        self.requestTimer?.invalidate()
        self.requestTimer = Timer.scheduledTimer(timeInterval: apiLatency,
                                                 target: self,
                                                 selector: #selector(fetchResultsFromAPI),
                                                 userInfo: nil,
                                                 repeats: false)
    }

    /// API Call: to fetch books based on search
    @objc private func fetchResultsFromAPI() {
        guard let searchVal = self.searchValue else {
            return
        }
        self.useCase.fetchBookList(searchVal) { [weak self] result  in
            switch result {
            case let .success(books):
                self?.loadData(books)
                self?.reloadTableView()
            case .failure(_):
                self?.stopLoaderIndicator()
            }
        }
    }

    func loadData(_ bookInfo: BookInfo) {
        if self.bookInfoMapper.isEmpty {
            reloadHintView()
        }
        self.bookInfoMapper = processFetched(bookInfo)
    }

    /// Create a Mapper model for cell item
    /// - Parameter bookInfo: BookInfo
    /// - Returns: [BookViewModelMapper]
    private func processFetched(_ bookInfo: BookInfo) -> [BookViewModelMapper] {
        return bookInfo.items.map { item in
            return BookViewModelMapper(title: item.volumeInfo.title,
                                        subTitle: item.volumeInfo.subtitle ?? "",
                                        smallImageUrl: item.volumeInfo.imageLinks.smallThumbnail ?? "",
                                        imageUrl: item.volumeInfo.imageLinks.thumbnail ?? "",
                                       authors: "",
                                       publisher: item.volumeInfo.publisher ?? "",
                                       publishedDate: item.volumeInfo.publishedDate ?? "",
                                       volumeInfoDescription: item.volumeInfo.volumeInfoDescription ?? ""
            )
        }
    }

    private func stopLoaderIndicator() {
        stopLoader.value = !stopLoader.value
    }
    
    private func reloadTableView() {
        stopLoaderIndicator()
        loadTable.value = !loadTable.value
    }
    
    private func reloadHintView() {
        stopLoaderIndicator()
        showHint.value = !showHint.value
    }
}

extension BookListViewModel: BookListOutputViewModel {
    var output: BookListOutputViewModel { return self }

    func handleFailure() {
        showAlert.value = !showAlert.value
    }
}
