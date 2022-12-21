//
//  BookDomainListDTO.swift
//  BookFinder
//
//  Created by Smriti Rana on 14/12/22.
//

import Foundation

struct BookDomainListDTO {
    let items: [Item]
}

extension BookDomainListDTO {
    
    func toPresentation() -> BookInfo {
        return .init(items: items)
    }
}
