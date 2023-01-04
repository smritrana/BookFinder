//
//  BookDetailViewModel.swift
//  BookFinder
//
//  Created by Smriti Rana on 21/12/22.
//

import UIKit

enum DetailCellType: Int, CaseIterable {
    case title
    case subTitle
    case publisher
    case published
    case volumeInfo
}

private struct DetailConstantValues {
   static let listScreenName = "Detail"
   static let unKnown =  "Unknown"
   static let title = "Title"
   static let subTitle = "subTitle"
   static let publisher =  "Publisher"
   static let publishedDate =  "Published Date"
   static let volume =  "Volume Description"
}

protocol BookDetailInputViewModel {
}

protocol BookDetailOutputViewModel {
    var loadTable: Dynamic<Bool> { get }
    var getScreenName: String {get}
    var bookInfo: BookViewModelMapper {get}
    func getNumberOfRows() -> Int
    func getSectionType(_ row: DetailCellType) -> (DetailCellType?, value :String)
    func checkForValues() -> ([DetailCellType])
}

protocol BookDetailViewModelType {
    var output: BookDetailOutputViewModel { get }
    var input: BookDetailInputViewModel { get }
}

final class BookDetailViewModel: BookDetailViewModelType, BookDetailInputViewModel, BookDetailOutputViewModel {

    var loadTable: Dynamic<Bool> = Dynamic(false)
    private var bookInfoMapper: BookViewModelMapper

    var input: BookDetailInputViewModel { return self }
    var output: BookDetailOutputViewModel { return self }

    init(_ bookInfo: BookViewModelMapper) {
        self.bookInfoMapper = bookInfo
    }

    /// Mapper class for list Item Cell
    var bookInfo: BookViewModelMapper {
        return bookInfoMapper
    }

    /// Detail Info
    /// - Parameter row: Int
    /// - Returns: detail Values to display
    func getSectionType(_ row: DetailCellType) -> (DetailCellType?,
                                                   value :String) {
        switch row {
        case DetailCellType.title:
            return (.title, "\(DetailConstantValues.title)"+": "+"\(bookInfoMapper.title)")
        case DetailCellType.subTitle:
            return (.subTitle, "\(DetailConstantValues.subTitle)"+": "+"\(bookInfoMapper.subTitle)")
        case DetailCellType.publisher:
            return (.publisher, "\(DetailConstantValues.publisher)"+": "+"\(bookInfoMapper.publisher)")
        case DetailCellType.published:
            return (.published, "\(DetailConstantValues.publishedDate)"+": "+"\(bookInfoMapper.publishedDate)")
        case DetailCellType.volumeInfo:
            return (.volumeInfo, "\(DetailConstantValues.volume)"+": "+"\(bookInfoMapper.volumeInfoDescription)")
        }
    }
    
    // Get Screen Name from constant
    var getScreenName: String {
        return DetailConstantValues.listScreenName
    }

    /// DescriptiongetNumberOfRows
    /// - Returns: Int
    func getNumberOfRows() -> Int {
        return checkForValues().count
    }

    /// Check for Cell type add only that have values
    /// - Returns: DetailCellType, Number of cell to be made
    func checkForValues() -> ([DetailCellType]) {
        var getCells = [DetailCellType]()
        !bookInfoMapper.title.isBlank ? getCells.append(DetailCellType.title) : ()
        !bookInfoMapper.subTitle.isBlank ? getCells.append(DetailCellType.subTitle) : ()
        !bookInfoMapper.publisher.isBlank ? getCells.append(DetailCellType.publisher) : ()
        !bookInfoMapper.publishedDate.isBlank ? getCells.append(DetailCellType.published) : ()
        !bookInfoMapper.volumeInfoDescription.isBlank ? getCells.append(DetailCellType.volumeInfo) : ()
        return getCells
    }
}
