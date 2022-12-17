//
//  MockData.swift
//  BookFinderTests
//
//  Created by Smriti Rana on 17/12/22.
//

import Foundation

@testable import BookFinder

class MockData {
    
    static var bookInfo: BookDataListDTO {
        try! JSONDecoder().decode(BookDataListDTO.self, from: bookData)
    }
    
    static var domainBooks: BookDomainListDTO {
        return bookInfo.toDmoain()
    }
    
    static var bookList: BookInfo {
        return domainBooks.toPresentation()
    }
    
    static var bookData: Data {
        loadJsonData("BookInfo")
    }
    
    static func loadJsonData(_ fromFile: String) -> Data {
        let path = Bundle(for: self).path(forResource: fromFile, ofType: "json")
        let jsonString = try! String(contentsOfFile: path!, encoding: .utf8)
        let data = jsonString.data(using: .utf8)!
        return data
    }
}
