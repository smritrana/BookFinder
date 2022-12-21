//
//  BookDomainListDTO.swift
//  BookFinder
//
//  Created by Smriti Rana on 14/12/22.
//

import Foundation

struct BookDataListDTO: Codable {
    let items: [Item]

    private enum CodingKeys: String, CodingKey {
        case items
    }
}

extension BookDataListDTO {
    
    func toDmoain() -> BookDomainListDTO {
        return .init(
            items: items)
    }
}

// MARK: - Item
struct Item: Codable {
    let volumeInfo: VolumeInfo
}

// MARK: - VolumeInfo
struct VolumeInfo: Codable {
    let title: String
    let subtitle: String?
    let publisher, publishedDate, volumeInfoDescription: String?
    let imageLinks: ImageLinks

    enum CodingKeys: String, CodingKey {
        case title, subtitle, publisher, publishedDate
        case volumeInfoDescription = "description"
        case imageLinks
    }
}

// MARK: - ImageLinks
struct ImageLinks: Codable {
    let smallThumbnail, thumbnail: String?
}
