//
//  UtilFunc.swift
//  BookFinder
//
//  Created by Smriti Rana on 21/12/22.
//

import Foundation

public func getImageUrl(_ urlImage: String) -> URL? {
    guard let imageURL = URL(string: urlImage.replacingOccurrences(of: "http", with: "https")) else { return URL(string: "")}
    return imageURL
}

extension String {

    var isBlank: Bool {
        return allSatisfy({ $0.isWhitespace })
    }
}
