//
//  Constant.swift
//  BookFinder
//
//  Created by Smriti Rana on 16/12/22.
//

import Foundation

let defaultImageForBook = "iconSaveNotFilled"

struct Configuration {
    static let apiKey = "AIzaSyC4Jx3NbDIz1a2sWPsHNG_nnPZDwEnUK94"
    static let host = "www.googleapis.com"
    static let scheme = "https"
    static let url = "URL"
}

struct APIPathUrl {
    static let findBookUrl = "/books/v1/volumes"
}

struct AccessibilityIdentifier {
    static let detailsView = "AccessibilityIdentifierDetailsView"
    static let searchField = "AccessibilityIdentifierSearch"
    static let listView = "AccessibilityIdentifierListView"
}
